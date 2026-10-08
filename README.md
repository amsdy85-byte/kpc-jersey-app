# KPC Jersey Order App — No Vercel Environment Variables

## Setup
1. Create a Supabase project.
2. In Supabase SQL Editor, run `schema.sql`.
3. Create an admin user in Supabase Authentication > Users.
4. Open `config.js` and replace only:
   - `SUPABASE_URL`
   - `SUPABASE_PUBLISHABLE_KEY`
   - bank details / price if needed
5. Upload the whole folder to GitHub.
6. Import the GitHub repo into Vercel. No Environment Variables are required.

## Security
The browser uses only the Supabase publishable/anon key. NEVER put a `service_role` key in `config.js`.
RLS policies in `schema.sql` allow public order creation but restrict order reads/updates to authenticated users.
For a stricter production admin policy, add an admin-role table or restrict authenticated users by email/domain.

## Customer flow
Home → Product → Customer → Jersey details → Review → Transfer → Done.

## Admin
Open `/#admin`, log in with the Supabase Auth user, then verify transfer and click Mark as Paid.
