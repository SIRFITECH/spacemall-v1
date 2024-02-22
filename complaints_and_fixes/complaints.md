# These are the complaints and Solutions for spacemall app during the beta test
## Number of tester so far : 10  as at Feb 1, 2024

### Complaints
1. The resend code button on the OTP screen not working
   1. Problem is: The code what making the wrong check, checking if timer is greater than 1 sec, which is always false when the resend code button is active
   2. Solution: Change the check to see if the timer is less the 1 sec. That way the button calls the resendOTP function in the authRepo
2. App gets stuck on the create profile page
   1. Problem is: User started the create profile process and left it half way, when they return, the app could not remember their UID 
   2. Solution: Force user to login again, that way the app can get the UID needed to create the profile
3. Users get error when they enter the mall
   1. Problem : User gets error about profile not existing 
   2. solution:  