create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  order_code text unique not null,
  customer_name text not null,
  customer_phone text not null,
  quantity integer not null check (quantity > 0 and quantity <= 30),
  total_amount integer not null,
  status text not null default 'WAITING_FOR_VERIFICATION',
  created_at timestamptz not null default now()
);

create table if not exists public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  item_no integer not null,
  size text not null,
  back_name text not null,
  back_number text not null,
  created_at timestamptz not null default now()
);

alter table public.orders enable row level security;
alter table public.order_items enable row level security;

-- Customer can create orders/items. Reading/updating is restricted to authenticated admins.
create policy "public can create orders" on public.orders for insert to anon, authenticated with check (true);
create policy "public can create order items" on public.order_items for insert to anon, authenticated with check (true);

create policy "authenticated can read orders" on public.orders for select to authenticated using (true);
create policy "authenticated can update orders" on public.orders for update to authenticated using (true) with check (true);
create policy "authenticated can read order items" on public.order_items for select to authenticated using (true);
