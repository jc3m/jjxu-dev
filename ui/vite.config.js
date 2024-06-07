import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig(() => {
  return {
    build: {
      outDir: 'build',
    },
    plugins: [react()],
    resolve: {
      alias: {
        components: '/src/components',
        core: '/src/core',
        pages: '/src/pages',
        utils: '/src/utils',
      },
    },
  };
});
