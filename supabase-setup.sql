-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create students table
CREATE TABLE IF NOT EXISTS students (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  roll_number TEXT NOT NULL,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Create admins table
CREATE TABLE IF NOT EXISTS admins (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  username TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Create concession_applications table
CREATE TABLE IF NOT EXISTS concession_applications (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  student_id UUID REFERENCES students(id),
  student_name TEXT NOT NULL,
  year TEXT NOT NULL,
  category TEXT NOT NULL,
  branch TEXT NOT NULL,
  from_station TEXT NOT NULL,
  to_station TEXT NOT NULL,
  class_type TEXT NOT NULL,
  railway_type TEXT NOT NULL,
  pass_type TEXT NOT NULL,
  date_of_birth DATE NOT NULL,
  concession_form_no TEXT NOT NULL,
  age INTEGER NOT NULL,
  previous_pass_date DATE NOT NULL,
  previous_pass_expiry DATE NOT NULL,
  season_ticket_no TEXT NOT NULL,
  id_card_url TEXT,
  aadhar_url TEXT,
  fee_receipt_url TEXT,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  valid_from TIMESTAMP,
  valid_until TIMESTAMP,
  is_expired BOOLEAN DEFAULT FALSE
);

-- Enable Row Level Security (RLS) if you want to secure data access
-- For now, we'll leave it open for simplicity but you should enable it in production

-- Sample Admin User (Change password in production)
-- Inserts only if admin doesn't exist to avoid duplicates
INSERT INTO admins (username, password_hash)
SELECT 'admin', 'admin123'
WHERE NOT EXISTS (SELECT 1 FROM admins WHERE username = 'admin');
