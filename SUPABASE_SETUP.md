# ⚡ THE ENCLAVE OS — 3-Minute Supabase Database Setup Guide

Welcome to **THE ENCLAVE (Ultra-Luxury Architectural Real Estate & Private Villa Portfolio OS)**.
Follow this 3-minute quickstart guide to connect your real-time cloud database.

---

### Step 1: Create a Free Supabase Project
1. Go to [https://supabase.com](https://supabase.com) and log in.
2. Click **"New Project"**, name it `the-enclave-db`, and choose a secure database password.
3. Select your closest hosting region and click **"Create New Project"**.

---

### Step 2: Run the Database Migrations (1-Click SQL)
1. In your Supabase dashboard, click on **"SQL Editor"** in the left sidebar.
2. Open `supabase/schema.sql` from this folder, copy all contents, paste it into the SQL Editor, and click **"Run"**.
3. (Optional) Open `supabase/seed.sql`, copy all contents, paste into the SQL Editor, and click **"Run"** to load the initial portfolio villas and documents.

---

### Step 3: Link Environment Variables
1. In Supabase, navigate to **Project Settings** &rarr; **API**.
2. Copy your **Project URL** and **anon public Key**.
3. Create a `.env` file in the root of your project:
```bash
VITE_SUPABASE_URL=https://your-project-ref.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
```

---

### Step 4: Launch Your Private Operating System
```bash
# Install dependencies
npm install

# Start local dev server
npm run dev

# Or build for production
npm run build
```

---

### 🕹️ Managing Partner Admin Passcode
- **Passkey**: `enclave2026`
- **Route**: Click **"ADMIN PASS"** in the top navigation bar or navigate to `/admin` to unlock the Broker Control Room, CRM leads, and portfolio management.

---

### 🛡️ Need White-Glove VIP Setup?
If you bought **Tier 3 ($3,500 White-Glove Rig)**, our engineering team handles end-to-end cloud deployment, custom domain DNS, SMTP email wiring, and database configuration for you. Contact support via your Gumroad receipt.
