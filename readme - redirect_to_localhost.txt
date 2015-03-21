1. Google console: APIs & Auth: Credentials: Create new Client ID:
Application type, choose "Installed Application" and type "Other"
2. Add environment variables with generated values:
  'GOOGLE_CLIENT_ID'
  'GOOGLE_CLIENT_SECRET'

PS: 3. and 4. are not mandatory as I included SSL certs in root app
3. Install SSL certificates.
  See "win_fetch_cacerts.rb" script (Works only on windows)
4. Add 'SSL_CERT_FILE' env variable with path to downloaded SSL certs.
5. Done