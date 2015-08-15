<?php

namespace Emergence\People;

#RegistrationRequestHandler::$onRegisterComplete = function(User $User, array $requestData) {
#    // this hook is run after a new user acconut has been registered (the user is waiting though so keep things moving!)
#
#    // add new user to a MailChimp list (see http://forum.laddr.io/t/mailchimp-integration/26)
#    \RemoteSystems\MailChimp::call('lists/subscribe', [
#        'id' => 'YOUR_LIST_ID_HERE',
#        'email' => [
#            'email' => $User->Email
#        ],
#        'merge_vars' => [
#            'FNAME' => $User->FirstName,
#            'LNAME' => $User->LastName
#        ],
#        'double_optin' => false,
#        'replace_interests' => false,
#        'send_welcome' => false
#    ]);
#};