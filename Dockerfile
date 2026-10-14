# Step 1: Use an ultra-lightweight Nginx server
FROM nginx:1.28-alpine

# Step 2: Copy your static files to the Nginx web root directory
COPY index.html /usr/share/nginx/html/index.html

# Step 3: Expose port 80 for incoming web traffic
EXPOSE 80

# Step 4: Run Nginx in the foreground to keep the container active
CMD ["nginx", "-g", "daemon off;"]

