##########################
#      Config below      #
##########################

bot_token = "x.x.x" # Bot token or set it to an env var

channel_id = 0 # Channel ID to send the embed to

url = "https://github.com/a/b" # Github url you want to check

old = "(Bot/server was reset)" # What to say when you reset (you could edit this to save and load commmit ids too)

##########################
#      Script below      #
##########################

import requests
import discord
import re
from discord.ext import tasks, commands
intents = discord.Intents.all()
client = commands.Bot(command_prefix="!?",intents=intents)

def get_commit_hash(): # Attempts to find the commit hash (iffy)
	response = requests.get(url)
	for line in response.text.split("\n"):
		if "commit" in line and "fragment" in line:
			commit = line.split("/")[4].split('"')[0]
			return commit

def get_commit_msg(commit): # Grabs the commit message from the patch file
	rq = requests.get(f'{url}/commit/{commit}.patch')
	match = re.search(r'^Subject: \[PATCH\] (.*)$', rq.text, re.MULTILINE)
	return match.group(1) if match else '⚠️ Failed to get update msg'

@client.event
async def on_ready():
	print("Bot is ready!")
	await check_loop.start()

@tasks.loop(seconds=60) # Set this to how often to check but remeber GH has a ratelimit
async def check_loop():
	global old
	print("Checking...")
	full_hash = get_commit_hash()
	new = full_hash[:7] # Shorten the hash to 7 long to match GitHub's commit history
	if new != old:
		print("New update hash: ",full_hash)
		channel = client.get_channel(channel_id)
		embed = discord.Embed(title="Repo updated:", description= "", color=0x7289da)
		embed.add_field(name="Old Commit", value="``"+old+"``", inline=True)
		embed.add_field(name="Last Commit", value="``"+new+"``", inline=True)
		embed.add_field(name="Commit msg", value="``"+get_commit_msg(full_hash)+"``",inline=False)
		embed.add_field(name="Commit changes", value=f'[Link]({url}/commit/{full_hash})')
		old = new
		await channel.send(embed=embed)
	else:
		print("Nothin new")

@check_loop.before_loop
async def before_some_task():
  await client.wait_until_ready()

client.run(bot_token)
#pyinstaller --clean --onefile main.py