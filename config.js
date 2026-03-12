// ============================================================
//  NeuroWeather — Supabase Configuration
//  Replace these two values after creating your free account
//  at https://supabase.com
// ============================================================

const SUPABASE_URL = 'https://trjiqoiweetbmuvauitk.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRyamlxb2l3ZWV0Ym11dmF1aXRrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMzMTUxNTAsImV4cCI6MjA4ODg5MTE1MH0.RHL92MvLX9mEagifxIjyXMZ_UaJgBl4rsKFYW4kPa3s';

// Claude AI — get free key at https://console.anthropic.com
const CLAUDE_API_KEY = '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';
const CLAUDE_MODEL   = 'claude-sonnet-4-20250514';

// Stripe — test publishable key from https://dashboard.stripe.com
const STRIPE_KEY = 'pk_test_51TA8Pw1Ue1RyCUgPeHJUwTaI7NJfejVfPkHcAVuYi4k850UHmsBSWOV384GEH4KMvkfdAs91vpyMVSYJW3xOn096003lPqUnZ6';

// Plan price IDs from Stripe dashboard (test mode)
const STRIPE_PRICES = {
  individual: 'price_1TA8bJ1Ue1RyCUgPb6oJAzCy',
  team:       'price_1TA8bd1Ue1RyCUgPc3xrVBw9',
  enterprise: 'price_1TA8bw1Ue1RyCUgP4COWYjzy',
};
