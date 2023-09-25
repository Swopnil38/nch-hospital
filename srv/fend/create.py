import gspread
from oauth2client.service_account import ServiceAccountCredentials

# Define your Google Sheets credentials JSON file path
CREDENTIALS_FILE = 'creative-sathi-d13f3e647e88.json'

# Define the name for the new spreadsheet
NEW_SPREADSHEET_NAME = 'Form Response'

try:
    # Authenticate using the credentials file
    scope = ["https://spreadsheets.google.com/feeds", "https://www.googleapis.com/auth/drive"]
    credentials = ServiceAccountCredentials.from_json_keyfile_name(CREDENTIALS_FILE, scope)
    client = gspread.authorize(credentials)

    # Create a new Google Sheets spreadsheet with the specified name
    new_spreadsheet = client.create(NEW_SPREADSHEET_NAME)

    # Share the spreadsheet with edit access to anyone with the link
    new_spreadsheet.share('', perm_type='anyone', role='writer')


    # Print the URL of the newly created spreadsheet
    print(f"New spreadsheet created: {new_spreadsheet.url}")
except Exception as e:
    print(f'Error: {str(e)}')
