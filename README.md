# KPC Jersey Order — MVP Production Setup

## Flow
Home → Product → Customer → Jersey details → Review → Transfer → Done.

Admin: login → Orders → verify transfer manually → Mark as Paid.

## 1. Create Supabase project
Create a project, open SQL Editor, and run `schema.sql`.

## 2. Configure the website
Copy `config.example.js` to `config.js` and enter your Supabase Project URL and anon key.

Change the bank details and jersey price there.

## 3. Connect Supabase JS
In `index.html`, add the Supabase JS CDN and replace the localStorage functions with the Supabase functions described in the implementation notes below.

## 4. Admin
Create an admin user in Supabase Authentication. For the first MVP, the admin dashboard should require email/password login before reading or changing orders.

## 5. Deploy
Upload the folder to Vercel, Netlify, Cloudflare Pages, or any static hosting. No server is required for the customer-facing page.

## Important before launch
- Replace the demo jersey image with the real jersey photo.
- Replace the demo size guide with the actual measured size chart.
- Replace demo bank account details.
- Add proper admin-only RLS before accepting real orders.
- Test order creation on mobile.
