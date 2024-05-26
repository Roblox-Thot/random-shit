from PIL import Image, ImageDraw
import os
import numpy as np

def kmeans(data, k, max_iters=100):
    centroids = data[np.random.choice(len(data), k, replace=False)]
    for _ in range(max_iters):
        labels = np.argmin(np.linalg.norm(data[:, np.newaxis] - centroids, axis=2), axis=1)
        new_centroids = np.array([data[labels == i].mean(axis=0) for i in range(k)])
        if np.all(centroids == new_centroids):
            break
        centroids = new_centroids
    return centroids, labels

def simplify_image(image_path, num_colors):
    img = Image.open(image_path)
    img_array = np.array(img)
    pixels = img_array.reshape(-1, 3)
    centroids, labels = kmeans(pixels, num_colors)
    simplified_pixels = centroids[labels]
    simplified_img_array = simplified_pixels.reshape(img_array.shape)
    simplified_img = Image.fromarray(simplified_img_array.astype(np.uint8))
    return simplified_img

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
    color_count:int = int(input("How many colors to simplify to: "))

    simp = simplify_image(image_path,color_count)
    simp.show()
    input("Press enter to separate the image into colors")
    separate_colors(simp)
