import flask
import gspread
from oauth2client.service_account import ServiceAccountCredentials


from srv import app
import os

# Get the absolute path to the JSON credentials file
SERVICE_ACCOUNT_JSON = {
  "type": "service_account",
  "project_id": "creative-sathi",
  "private_key_id": "d13f3e647e8836262c1c52e893f02b45b0ce3db9",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC7OWgwX1GquufX\np8uwRTG7ncRAbEV6KtiTWYT7ZkuxXewSdqPRmWEXdZ5DylvzcFvNicDGjvPrQBda\nKfUJeSFLROIEBg/qcM87v2EAibYaXI1QwexF1Cyqw37C4Y3bXgdD8zLxpXdRYVCb\n9zbNEooCSGp7Af9tnQfHHnhzHYr6AMISTEPOTPsXBE+kDnvIU4pzsLrBO6EYjQdi\n7e3ukRNQvCxhG1OUN51dBhRD49lrwLW6BJQFGEhpEyKlJl9//e/rdfKDoAUC6Yas\nDVvvKaTcfbdpMlpdjZoZ5lS6Ur0wshTgMziMAk1TeNQPngPM/UqRvb6BVW/SFkJ2\naxdF7HP5AgMBAAECggEABz+jElxeY7x2GsSwVNQY/NPliT5SjPb5CPC/qUwTRNFc\nwR+UGsVUG6hoxuR1cui4D9ke0ZEvTb20KcAoxdkeujSh24NbPQ8Ttuh4mktlStf9\nJfycEogIbVlsSvdDRWmlNl2awf2kr6M+OmDz34oG4IJqkktILGJBWYA11vR0hlai\n3HrtXBxeDBSjdKHNjgyeFhsQkpjTLKbYWZe928pi190suyB6hnlyFP5KR4o4GXua\nzxcgjnUTUQh6i4LgUDaXZS4UCxNDfCxIA85JaQP9PM8XGvQ8pVVViXUiUftXl99D\nbAL9GQa4llHjxcsiF7qcGgLReIn8sZbmJ6cBEf2N0QKBgQDn/kMCO7W0BwRmJ1E3\nt4ceKMXnIYa3sdr96jBVmFrnejv7g21ZQKBK36dcvTmmkRCMPg/zQykjYLz/l4J6\ngjN8J8uSMnjXnF8FnR9eQ4yvmG/fOxXGs/JkloZqicfbsvv5uqlshfOg5uJZzeqI\n6thO95fDE62MkBx8+bflxvelqwKBgQDOmStfzZt/yV9WMHi08k+0hsyOttaiFrf9\nUf0C7WRzcmmqT6JgZtS+Zrt6RG2y85rgtCA/3+cpzBcWaLRS/Vz9Iwd6btF++q0O\n1pnKWjgbQXcNHGu3sPCci9lprGgDvVJ+oiI8WZ2CndfHo+E61HyTSHdr9KN1ZNvM\nXAcyvaYg6wKBgQDJvONMZ9wEZy2+H2aTCvdmlJI0AYWC7BjBQQszA7/ZFwReHNXU\nDUzWj1KcZLhjTjaTncyE/9wgNZlksb33Bo364yg1Q8qtw/8lhJKoiBkpAWgXOOwg\n1I5uRi8xKgsv058mdNmr03gebWhcK6JN2dqsIMZKDyyV1SPQ0d7G45Sq7QKBgDok\niTxxFO4lshsDkTT7bMsVlMQlWMpNMoKsbFRCkx6aeHph5wTSa9UZ/HEwiN7wCApt\nJxZS4S+2LFk2JmmkvGLRVO1z+qmNyt5+LtHwChJBnkumT/pmZZDpGsrOpodG5MyW\nvKPXZKi521xoFp8D5ftdTZ6oPshvFhyxWaVCElr5AoGBAOHI76ViYtYvCuQswXob\nJQjpRYsAQAdU85hxt78jii45URI/1pJenIBV/c6EYLpsMggrH/7XqHvrolzQ4Llg\n06D1a8Gp8qbh+esYalLF4s6DOFCJWQ1D0ykfNROGYXEdyLBhUFctXq54Ff3Q6T4v\nMOk0C8HGgfvl2eNlYH4LD2yj\n-----END PRIVATE KEY-----\n",
  "client_email": "nch-hospital@creative-sathi.iam.gserviceaccount.com",
  "client_id": "112507844580018431924",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/nch-hospital%40creative-sathi.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

# Define the name of your Google Sheets spreadsheet
SPREADSHEET_URL = 'https://docs.google.com/spreadsheets/d/1s1vmi4PWEzh9vpyn7CvSR8bwmGEHLOQ7wF2k1ZsGfNs/edit#gid=0'



@app.post('/contact/form/submit')
def getContactForm():
    name = flask.request.form.get('name')
    email = flask.request.form.get('email')
    phone = flask.request.form.get('phone')
    subject = flask.request.form.get('subject')
    message = flask.request.form.get('message')

    values = [name, email, phone, subject, message]

    try:
        credentials = ServiceAccountCredentials.from_json_keyfile_dict(SERVICE_ACCOUNT_JSON)
        client = gspread.authorize(credentials)

        # Open the specified Google Sheets spreadsheet by URL
        spreadsheet = client.open_by_url(SPREADSHEET_URL)

        # Select the first worksheet (you can modify this as needed)
        worksheet = spreadsheet.get_worksheet(0)

        # Append the data to the worksheet
        worksheet.append_rows([values])

        return 'Data submitted successfully!'
    except Exception as e:
        return f'Error: {str(e)}'