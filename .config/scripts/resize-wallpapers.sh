#!/bin/bash

# Directory containing images
input_dir="$HOME/Pictures/Wallpapers"
output_dir="$HOME/Pictures/Wallpapers2"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop through all image files in the input directory
for img in "$input_dir"/*; do
  # Get the base name of the file (without the path)
  filename=$(basename "$img")

  # Get the file name without extension
  base_name="${filename%.*}"

  # Convert and resize the image to 1080p, save as JPG
  magick "$img" -resize 1920x1080! "$output_dir/${base_name}.jpg"

  echo "Processed: $img -> $output_dir/${base_name}.jpg"
done

echo "All images processed."
