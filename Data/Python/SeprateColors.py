"""
Simplify images then seprate them into colors with the hex color as the name
Fair warning this is almost all GPT lmao
"""

from PIL import Image, ImageDraw
import numpy as np
import random,os

def initialize_centroids(pixels, k):
    return random.sample(list(pixels), k)

def assign_clusters(pixels, centroids):
    clusters = [[] for _ in centroids]
    for pixel in pixels:
        distances = [np.linalg.norm(pixel - centroid) for centroid in centroids]
        closest_centroid_index = np.argmin(distances)
        clusters[closest_centroid_index].append(pixel)
    return clusters

def update_centroids(clusters):
    new_centroids = []
    for cluster in clusters:
        if cluster:
            new_centroid = np.mean(cluster, axis=0)
            new_centroids.append(new_centroid)
        else:
            new_centroids.append(np.zeros(len(clusters[0][0])))
    return new_centroids

def kmeans(pixels, k, max_iters=100, tol=1e-4):
    centroids = initialize_centroids(pixels, k)
    for _ in range(max_iters):
        clusters = assign_clusters(pixels, centroids)
        new_centroids = update_centroids(clusters)
        diff = np.linalg.norm(np.array(new_centroids) - np.array(centroids))
        if diff < tol:
            break
        centroids = new_centroids
    return centroids, clusters

def simplify_image(image_path, color_count):
    try:
        img = Image.open(image_path)
        img = img.convert('RGB')
        img_array = np.array(img)

        if len(img_array.shape) != 3 or img_array.shape[2] != 3:
            raise ValueError("Image is not in RGB format or is corrupted")

        pixels = img_array.reshape(-1, 3)
        centroids, clusters = kmeans(pixels, color_count)

        new_pixels = []
        for pixel in pixels:
            distances = [np.linalg.norm(pixel - centroid) for centroid in centroids]
            closest_centroid_index = np.argmin(distances)
            new_pixels.append(centroids[closest_centroid_index])

        new_pixels = np.array(new_pixels).reshape(img_array.shape).astype(np.uint8)

        new_img = Image.fromarray(new_pixels)
        return new_img

    except Exception as e:
        print(f"An error occurred: {e}")

def separate_colors(original_image):
    unique_colors = set(original_image.getdata())

    if not os.path.exists("color_images"):
        os.mkdir("color_images")

    for color in unique_colors:
        color_image = Image.new("RGBA", original_image.size, (0, 0, 0, 0))
        
        draw = ImageDraw.Draw(color_image)
        for x in range(original_image.width):
            for y in range(original_image.height):
                pixel_color = original_image.getpixel((x, y))
                if pixel_color == color:
                    draw.point((x, y), fill=color)
        
        color_code = f"{color[0]:02X}{color[1]:02X}{color[2]:02X}"
        image_filename = f"{color_code}.png"
        color_image.save(os.path.join("color_images", image_filename))

if __name__ == "__main__":
    image_path:str = input("Image Path: ").replace("\"", "")
    img = Image.open(image_path)
    print(f'\nCurrent unique color count: {len(set(img.getdata()))}\n')
    color_count:int = int(input("How many colors to simplify to: "))

    print(f'\nThis may take a while...\n')
    simp = simplify_image(image_path,color_count)
    print(f'\nShowing image preview, close it to continue\n')
    simp.show()
    input("Press enter to separate the image")
    separate_colors(simp)
