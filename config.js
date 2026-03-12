// ============================================================
//  NeuroWeather — Supabase Configuration
//  Replace these two values after creating your free account
//  at https://supabase.com
// ============================================================

const SUPABASE_URL = 'https://trjiqoiweetbmuvauitk.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_i1a_ahnEAHTGAlF2HFypqw_MiWTfZo2';

// Claude AI — get free key at https://console.anthropic.com
const CLAUDE_API_KEY = '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';
const CLAUDE_MODEL   = 'claude-sonnet-4-20250514';

// Stripe — test publishable key from https://dashboard.stripe.com
const STRIPE_KEY = 'pk_test_51TA8Pw1Ue1RyCUgPeHJUwTaI7NJfejVfPkHcAVuYi4k850UHmsBSWOV384GEH4KMvkfdAs91vpyMVSYJW3xOn096003lPqUnZ6';

// Plan price IDs from Stripe dashboard (test mode)
const STRIPE_PRICES = {
  individual: 'prod_U8PQvj9oxPHIvH',
  team:       'prod_U8PQRTai2eMTxn',
  enterprise: 'prod_U8PQzTKHc2NbGp',
};
