# Makerspace
  Keeps track of sign-ins / sign-outs for the Makerspace at The Point.

  List of users including emails, status is kept in Firebase.
    
    - Admins have the ability to change this list
    
  Realtime updates to Firebase when a user signs in / out.
    
    - History log updated with start time and end time, as well as the specific room selected
    
  Specific information is kept for individual rooms.
    
    - Total users, total unique users
    
  Can update Firebase user list from Google Sheet shared with The Point
  
    - Updates every 15 mins, must create rows that have not been previously used for Firebase to be updated.
