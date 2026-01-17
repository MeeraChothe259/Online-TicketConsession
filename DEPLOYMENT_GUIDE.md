# Deployment Guide for Online Ticket Concession

Since your project is hosted on GitHub, the easiest way to deploy your Vite + React application is using **Vercel** or **Netlify**.

## Option 1: Deploy with Vercel (Recommended)

1.  **Create an Account**: Go to [vercel.com](https://vercel.com/signup) and sign up using your **GitHub** account.
2.  **Import Project**:
    *   On your Vercel dashboard, click **"Add New..."** -> **"Project"**.
    *   In the "Import Git Repository" section, find your repository `Online-ticket-concession` and click **"Import"**.
3.  **Configure Project**:
    *   **Framework Preset**: It should automatically detect `Vite`. If not, select it manually.
    *   **Root Directory**: Leave as `./`.
4.  **Environment Variables (Crucial)**:
    *   Expand the **"Environment Variables"** section.
    *   You need to add the same variables from your local `.env` file:
        *   **Name**: `VITE_SUPABASE_URL` | **Value**: `your_supabase_url`
        *   **Name**: `VITE_SUPABASE_ANON_KEY` | **Value**: `your_supabase_anon_key`
    *   *Note: Copy these values from your local `.env` file or Supabase dashboard.*
5.  **Deploy**: Click **"Deploy"**.
    *   Vercel will build your project. Wait for a minute or two.
    *   Once done, you will get a live URL (e.g., `https://online-ticket-concession.vercel.app`).

---

## Option 2: Deploy with Netlify

1.  **Create an Account**: Go to [netlify.com](https://www.netlify.com/) and sign up with GitHub.
2.  **New Site**: Click **"Add new site"** -> **"Import from an existing project"**.
3.  **Connect to GitHub**: Choose GitHub and select your repository `Online-ticket-concession`.
4.  **Build Settings**:
    *   **Build command**: `npm run build`
    *   **Publish directory**: `dist`
5.  **Environment Variables**:
    *   Click on **"Show advanced"** or go to "App settings" after creation.
    *   Add your `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` key-value pairs.
6.  **Deploy Site**: Click **"Deploy site"**.

---

## Important: Supabase Configuration

After deploying, ensures your Supabase project accepts requests from your new domain.

1.  Go to your [Supabase Dashboard](https://supabase.com/dashboard).
2.  Navigate to **Authentication** -> **URL Configuration**.
3.  Add your new **Vercel/Netlify URL** to the **Site URL** or **Redirect URLs** list.
    *   *Example*: `https://your-project-name.vercel.app`
4.  Calculated! now your app can securely talk to Supabase.
