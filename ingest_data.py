import os
from google.cloud import storage

# --- KONFIGURACJA ---
BUCKET_NAME = 'bank-churn-data-anastasija-stadnyk'  # <--- To Twoja nazwa!
SOURCE_FILE_NAME = 'churn_data.csv' 
DESTINATION_BLOB_NAME = 'raw/bank_churn.csv'
PATH_TO_CREDENTIALS = 'credentials.json'
# --------------------
def upload_to_bucket(bucket_name, source_file_name, destination_blob_name):
    print(f"Próba wgrania {source_file_name}...")
    try:
        storage_client = storage.Client.from_service_account_json(PATH_TO_CREDENTIALS)
        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(destination_blob_name)
        blob.upload_from_filename(source_file_name)
        print(f"✓ Sukces! Plik wgrany do {bucket_name}")
    except Exception as e:
        print(f"✗ Błąd: {e}")

if __name__ == "__main__":
    upload_to_bucket(BUCKET_NAME, SOURCE_FILE_NAME, DESTINATION_BLOB_NAME)
