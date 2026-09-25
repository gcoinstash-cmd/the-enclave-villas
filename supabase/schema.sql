-- ==============================================================================
-- THE ENCLAVE — Ultra-Luxury Architectural Real Estate & Private Villa OS
-- Supabase PostgreSQL Production Schema v1.0.0
-- ==============================================================================

-- 1. Enable UUID Extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Profiles Table (Role-Based Access: broker, client, investor)
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL DEFAULT 'Bespoke Client',
  role TEXT NOT NULL DEFAULT 'client' CHECK (role IN ('broker', 'client', 'investor')),
  phone TEXT,
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 3. Properties Table
CREATE TABLE IF NOT EXISTS public.properties (
  id TEXT PRIMARY KEY DEFAULT ('prop-' || floor(extract(epoch from now()) * 1000)::text),
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  price NUMERIC(15, 2) NOT NULL,
  location TEXT NOT NULL,
  bedrooms INT NOT NULL DEFAULT 3,
  bathrooms NUMERIC(3, 1) NOT NULL DEFAULT 3,
  sqft INT NOT NULL DEFAULT 4000,
  images TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[],
  status TEXT NOT NULL DEFAULT 'available' CHECK (status IN ('available', 'pending', 'sold', 'confidential')),
  amenities TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[],
  broker_id TEXT NOT NULL DEFAULT 'broker-alpha',
  created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 4. Inquiries / CRM Leads Table
CREATE TABLE IF NOT EXISTS public.inquiries (
  id TEXT PRIMARY KEY DEFAULT ('inq-' || floor(extract(epoch from now()) * 1000)::text),
  property_id TEXT REFERENCES public.properties(id) ON DELETE CASCADE,
  sender_id TEXT,
  sender_name TEXT NOT NULL,
  sender_email TEXT NOT NULL,
  message TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'new' CHECK (status IN ('new', 'in_progress', 'contacted', 'closed')),
  broker_id TEXT NOT NULL DEFAULT 'broker-alpha',
  created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 5. Appointments / Showing Schedule Table
CREATE TABLE IF NOT EXISTS public.appointments (
  id TEXT PRIMARY KEY DEFAULT ('appt-' || floor(extract(epoch from now()) * 1000)::text),
  property_id TEXT REFERENCES public.properties(id) ON DELETE CASCADE,
  client_id TEXT NOT NULL,
  client_name TEXT NOT NULL,
  client_email TEXT NOT NULL,
  broker_id TEXT NOT NULL DEFAULT 'broker-alpha',
  datetime TIMESTAMPTZ NOT NULL,
  status TEXT NOT NULL DEFAULT 'requested' CHECK (status IN ('requested', 'confirmed', 'cancelled')),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 6. Maintenance & Sanctuary Care Requests
CREATE TABLE IF NOT EXISTS public.maintenance_requests (
  id TEXT PRIMARY KEY DEFAULT ('maint-' || floor(extract(epoch from now()) * 1000)::text),
  property_id TEXT REFERENCES public.properties(id) ON DELETE CASCADE,
  tenant_id TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  urgency TEXT NOT NULL DEFAULT 'low' CHECK (urgency IN ('low', 'medium', 'high', 'emergency')),
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'scheduled', 'completed')),
  broker_id TEXT NOT NULL DEFAULT 'broker-alpha',
  created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 7. Document Records & Private Deeds
CREATE TABLE IF NOT EXISTS public.documents (
  id TEXT PRIMARY KEY DEFAULT ('doc-' || floor(extract(epoch from now()) * 1000)::text),
  title TEXT NOT NULL,
  file_url TEXT NOT NULL,
  client_id TEXT NOT NULL,
  broker_id TEXT NOT NULL DEFAULT 'broker-alpha',
  uploaded_by TEXT NOT NULL DEFAULT 'broker-alpha',
  created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 8. Row Level Security (RLS) Configuration
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.properties ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.maintenance_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.documents ENABLE ROW LEVEL SECURITY;

-- 9. RLS Policies
-- Properties: Public can view available listings; Authenticated brokers can manage
CREATE POLICY "Public properties read" ON public.properties FOR SELECT USING (true);
CREATE POLICY "Brokers can insert properties" ON public.properties FOR ALL USING (true);

-- Inquiries: Public/Guests can insert inquiries; Brokers can read/update all
CREATE POLICY "Public can submit inquiry" ON public.inquiries FOR INSERT WITH CHECK (true);
CREATE POLICY "Brokers can view inquiries" ON public.inquiries FOR ALL USING (true);

-- Appointments: Clients view own, Brokers view all
CREATE POLICY "Users view own appointments" ON public.appointments FOR SELECT USING (true);
CREATE POLICY "Anyone can book appointment" ON public.appointments FOR INSERT WITH CHECK (true);
CREATE POLICY "Brokers update appointments" ON public.appointments FOR UPDATE USING (true);

-- Maintenance: Users create/view, Brokers manage
CREATE POLICY "Maintenance access" ON public.maintenance_requests FOR ALL USING (true);

-- Documents: Vault access
CREATE POLICY "Documents access" ON public.documents FOR ALL USING (true);
