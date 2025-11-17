-- Create Test User for Development
-- Run this in Supabase SQL Editor to create a test user with a known UUID

-- Test user ID: 00000000-0000-0000-0000-000000000002
-- This UUID is used in the frontend as MOCK_USER_ID

-- 1. Create test user profile
INSERT INTO user_profiles (id, email, telegram_chat_id, telegram_username)
VALUES (
  '00000000-0000-0000-0000-000000000002',
  'test@example.com',
  NULL,
  'test_user'
)
ON CONFLICT (id) DO NOTHING;

-- 2. Create test user preferences
INSERT INTO user_preferences (
  user_id,
  countries,
  cities,
  check_frequency,
  telegram_enabled,
  email_enabled,
  web_enabled,
  sound_enabled,
  auto_check_enabled,
  telegram_chat_id
)
VALUES (
  '00000000-0000-0000-0000-000000000002',
  '{}',
  '{}',
  5,
  false,
  false,
  true,
  true,
  false,
  NULL
)
ON CONFLICT (user_id) DO NOTHING;

-- 3. Verify
SELECT 
  'Test user created successfully!' as status,
  up.id,
  up.email,
  up.telegram_chat_id,
  pref.countries,
  pref.cities
FROM user_profiles up
LEFT JOIN user_preferences pref ON up.id = pref.user_id
WHERE up.id = '00000000-0000-0000-0000-000000000002';

