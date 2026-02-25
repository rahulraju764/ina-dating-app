/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{html,ts}",
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          pink: '#E91E8C',
          coral: '#FF6B6B',
          yellow: '#FFD93D',
        },
        dark: {
          bg1: '#0D0D0D',
          bg2: '#111827',
          surface1: '#1A1A2E',
          surface2: '#2A2A3E',
        },
        feedback: {
          success: '#00C896',
          error: '#FF4757',
        }
      },
      fontFamily: {
        display: ['Playfair Display', 'serif'],
        sans: ['DM Sans', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
