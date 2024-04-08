#!/bin/bash

# Function to display usage instructions
display_usage() {
    echo "Usage: $0 project_name"
    echo "Example: $0 my_vue_project"
    exit 1
}

# Check if a project name is provided
if [ $# -eq 0 ]; then
    display_usage
fi

# Check if node and npm are installed
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null ; then
    echo "Node.js and npm are required. Please install them."
    exit 1
fi

# Install Vue CLI
npm install -g @vue/cli

# Create a new Vue Nuxt project with TypeScript
vue create --preset nuxt-community/typescript-template $1

# Change directory to the project folder
cd $1

# Install Pinia
npm install pinia

# Install Vite
npm install vite

# Install Tailwind CSS
npm install tailwindcss@latest postcss@latest autoprefixer@latest

# Initialize Tailwind CSS
npx tailwindcss init -p

# Add Tailwind CSS plugin to Vite config
echo "import { defineConfig } from 'vite'\nimport vue from '@vitejs/plugin-vue'\nimport { vitePlugin as PiniaPlugin } from 'pinia'\nimport { viteSvgIcons } from 'vite-plugin-svg-icons'\nimport path from 'path'\n\n// https://vitejs.dev/config/\nexport default defineConfig({\n  plugins: [\n    vue(),\n    PiniaPlugin(),\n    viteSvgIcons({\n      iconDirs: [path.resolve(process.cwd(), 'src/assets/icons')],\n      symbolId: 'icon-[name]'\n    })\n  ],\n  resolve: {\n    alias: {\n      '@': path.resolve(__dirname, 'src')\n    }\n  },\n  css: {\n    preprocessorOptions: {\n      scss: {\n        additionalData: `@import '@/assets/scss/main.scss';`\n      }\n    }\n  }\n})" > vite.config.ts

# Open project folder in Nano
nano .

echo "Project setup complete. Happy coding!"
