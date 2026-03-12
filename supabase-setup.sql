-- ============================================================
--  NeuroWeather — Supabase Database Setup
--  Run this entire file in:
--  Supabase Dashboard → SQL Editor → New Query → Run
-- ============================================================

-- 1. PROFILES TABLE
-- Stores every user's data after they sign up
create table if not exists public.profiles (
  id               uuid references auth.users on delete cascade primary key,
  full_name        text,
  email            text unique,
  organization     text,
  role             text default 'user' check (role in ('user', 'leader', 'admin')),
  plan             text default 'demo' check (plan in ('demo', 'individual', 'team', 'enterprise')),
  plan_expires_at  timestamptz,
  created_at       timestamptz default now(),
  updated_at       timestamptz default now()
);

-- 2. SESSIONS TABLE
-- Leaders can view and edit cognitive session data for their team
create table if not exists public.sessions (
  id               uuid default gen_random_uuid() primary key,
  leader_id        uuid references public.profiles(id) on delete cascade,
  member_name      text not null,
  member_email     text,
  focus_score      integer default 75 check (focus_score between 0 and 100),
  stress_score     integer default 25 check (stress_score between 0 and 100),
  fatigue_score    integer default 30 check (fatigue_score between 0 and 100),
  overall_score    integer default 70 check (overall_score between 0 and 100),
  condition_label  text default 'Good',
  notes            text,
  session_date     date default current_date,
  created_at       timestamptz default now(),
  updated_at       timestamptz default now()
);

-- 3. AUTO-CREATE PROFILE ON SIGNUP
-- This trigger fires every time a new user signs up via Supabase Auth
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, full_name, email, role, plan, plan_expires_at)
  values (
    new.id,
    new.raw_user_meta_data->>'full_name',
    new.email,
    coalesce(new.raw_user_meta_data->>'role', 'user'),
    coalesce(new.raw_user_meta_data->>'plan', 'demo'),
    case
      when new.raw_user_meta_data->>'plan' = 'demo' or new.raw_user_meta_data->>'plan' is null
      then now() + interval '3 days'
      else null
    end
  )
  on conflict (id) do nothing;
  return new;
end;
$$ language plpgsql security definer;

-- Attach trigger to auth.users
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- 4. ROW LEVEL SECURITY (RLS)
-- Users can only see their own data. Leaders can see their team sessions.
alter table public.profiles enable row level security;
alter table public.sessions enable row level security;

-- Profiles: users can read and update their own profile
create policy "Users can view own profile"
  on public.profiles for select
  using (auth.uid() = id);

create policy "Users can update own profile"
  on public.profiles for update
  using (auth.uid() = id);

-- Sessions: leaders can manage sessions they created
create policy "Leaders can view own sessions"
  on public.sessions for select
  using (auth.uid() = leader_id);

create policy "Leaders can insert sessions"
  on public.sessions for insert
  with check (auth.uid() = leader_id);

create policy "Leaders can update own sessions"
  on public.sessions for update
  using (auth.uid() = leader_id);

create policy "Leaders can delete own sessions"
  on public.sessions for delete
  using (auth.uid() = leader_id);

-- 5. SAMPLE SEED DATA (optional — for testing leader view)
-- Uncomment and replace 'YOUR-LEADER-UUID' with a real leader user id
/*
insert into public.sessions (leader_id, member_name, focus_score, stress_score, fatigue_score, overall_score, condition_label)
values
  ('YOUR-LEADER-UUID', 'Member A', 42, 65, 70, 38, 'At Risk'),
  ('YOUR-LEADER-UUID', 'Member B', 55, 48, 55, 50, 'Tired'),
  ('YOUR-LEADER-UUID', 'Member C', 89, 18, 20, 88, 'Peak'),
  ('YOUR-LEADER-UUID', 'Member D', 82, 22, 25, 81, 'High'),
  ('YOUR-LEADER-UUID', 'Member E', 76, 28, 30, 74, 'Good'),
  ('YOUR-LEADER-UUID', 'Member F', 91, 15, 18, 90, 'Peak'),
  ('YOUR-LEADER-UUID', 'Member G', 68, 32, 40, 65, 'OK'),
  ('YOUR-LEADER-UUID', 'Member H', 85, 20, 22, 84, 'High');
*/
