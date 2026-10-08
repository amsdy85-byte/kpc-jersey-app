create extension if not exists pgcrypto;

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  order_code text unique not null,
  customer_name text not null,
  customer_phone text not null,
  quantity integer not null check (quantity between 1 and 30),
  total_amount integer not null,
  payment_status text not null default 'WAITING_FOR_VERIFICATION' check (payment_status in ('WAITING_FOR_VERIFICATION','PAID')),
  created_at timestamptz not null default now()
);

create table if not exists public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  item_no integer not null,
  size text not null check (size in ('S','M','L','XL','XXL')),
  back_name text not null,
  back_number text not null,
  created_at timestamptz not null default now()
);

alter table public.orders enable row level security;
alter table public.order_items enable row level security;

create policy "public can create orders" on public.orders for insert to anon, authenticated with check (true);
create policy "public can create items" on public.order_items for insert to anon, authenticated with check (true);
create policy "admins can read orders" on public.orders for select to authenticated using (true);
create policy "admins can read items" on public.order_items for select to authenticated using (true);
create policy "admins can update payment" on public.orders for update to authenticated using (true) with check (true);

-- After creating your admin user in Supabase Auth, replace the email below and run:
-- update public.profiles set is_admin = true where email = 'YOUR_ADMIN_EMAIL';

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text unique not null,
  is_admin boolean not null default false
);

alter table public.profiles enable row level security;
create policy "users read own profile" on public.profiles for select to authenticated using (id = auth.uid());

-- Make the admin policies stricter after testing by using profiles.is_admin in a helper function if desired.
