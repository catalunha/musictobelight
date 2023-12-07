# User
id
email
is_active

# Profile
id
user (User)
name
offices [Office]

# Office
id
name
code {coordinator, member}

# Album
id
name
profile (Profile)
listeners [User]

# Music
id
name
description
letter
url
album (Album)
