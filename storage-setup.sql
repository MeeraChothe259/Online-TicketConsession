-- Enable the storage schema if it's not already (it usually is)
-- but we can't do that here easily. Assuming storage extension is active.

-- 1. Create the buckets (public = true)
INSERT INTO storage.buckets (id, name, public)
VALUES ('id-cards', 'id-cards', true)
ON CONFLICT (id) DO UPDATE SET public = true;

INSERT INTO storage.buckets (id, name, public)
VALUES ('aadhar-cards', 'aadhar-cards', true)
ON CONFLICT (id) DO UPDATE SET public = true;

INSERT INTO storage.buckets (id, name, public)
VALUES ('fee-receipts', 'fee-receipts', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- 2. Drop existing policies to ensure clean slate
DROP POLICY IF EXISTS "Public View ID Cards" ON storage.objects;
DROP POLICY IF EXISTS "Public View Aadhar Cards" ON storage.objects;
DROP POLICY IF EXISTS "Public View Fee Receipts" ON storage.objects;
DROP POLICY IF EXISTS "Student Upload ID Cards" ON storage.objects;
DROP POLICY IF EXISTS "Student Upload Aadhar Cards" ON storage.objects;
DROP POLICY IF EXISTS "Student Upload Fee Receipts" ON storage.objects;

-- 3. Create policies for VIEWING files (Select) - Allow everyone since buckets are public
CREATE POLICY "Public View ID Cards"
ON storage.objects FOR SELECT
USING ( bucket_id = 'id-cards' );

CREATE POLICY "Public View Aadhar Cards"
ON storage.objects FOR SELECT
USING ( bucket_id = 'aadhar-cards' );

CREATE POLICY "Public View Fee Receipts"
ON storage.objects FOR SELECT
USING ( bucket_id = 'fee-receipts' );

-- 4. Create policies for UPLOADING files (Insert) - Allow authenticated users (students)
CREATE POLICY "Student Upload ID Cards"
ON storage.objects FOR INSERT
WITH CHECK ( bucket_id = 'id-cards' AND auth.role() = 'authenticated' );

CREATE POLICY "Student Upload Aadhar Cards"
ON storage.objects FOR INSERT
WITH CHECK ( bucket_id = 'aadhar-cards' AND auth.role() = 'authenticated' );

CREATE POLICY "Student Upload Fee Receipts"
ON storage.objects FOR INSERT
WITH CHECK ( bucket_id = 'fee-receipts' AND auth.role() = 'authenticated' );

-- 5. Optional: Allow users to update/delete their own files (if needed, but not critical for visibility)
