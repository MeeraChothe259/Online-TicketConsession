
import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';
dotenv.config();

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase credentials in .env');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkBuckets() {
    console.log('Checking storage buckets...');

    const requiredBuckets = ['id-cards', 'aadhar-cards', 'fee-receipts'];
    let allGood = true;

    const { data: buckets, error } = await supabase.storage.listBuckets();

    if (error) {
        console.error('Error listing buckets:', error.message);
        return;
    }

    const existingBucketNames = buckets.map(b => b.name);

    for (const bucket of requiredBuckets) {
        if (existingBucketNames.includes(bucket)) {
            console.log(`✅ Bucket '${bucket}' exists.`);
        } else {
            console.log(`❌ Bucket '${bucket}' is MISSING.`);
            allGood = false;
        }
    }

    if (!allGood) {
        console.log('\n⚠️  ACTION REQUIRED: You need to create the missing buckets in your Supabase Dashboard.');
        console.log('1. Go to Storage');
        console.log('2. Click "New Bucket"');
        console.log('3. Name it exactly as shown above (e.g., "id-cards")');
        console.log('4. Toggle "Public bucket" to ON');
        console.log('5. Click "Save"');
    } else {
        console.log('\nAll buckets seem to exist. If images are still not showing, check RLS policies.');
    }
}

checkBuckets();
