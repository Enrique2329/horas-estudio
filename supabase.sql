-- Horas de Estudio: tabla para sincronizar los datos entre dispositivos.
-- Pégalo en Supabase → SQL Editor → New query → Run.
create table if not exists public.app_state (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb       not null,
  rev        bigint      not null default 1,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;

-- Cada usuario solo ve y modifica su propia fila
drop policy if exists "leer lo propio" on public.app_state;
drop policy if exists "crear lo propio" on public.app_state;
drop policy if exists "editar lo propio" on public.app_state;
create policy "leer lo propio"   on public.app_state for select to authenticated using (auth.uid() = user_id);
create policy "crear lo propio"  on public.app_state for insert to authenticated with check (auth.uid() = user_id);
create policy "editar lo propio" on public.app_state for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

grant select, insert, update on public.app_state to authenticated;
