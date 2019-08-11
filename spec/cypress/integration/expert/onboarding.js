describe('Expert Onboarding', function() {
  beforeEach(() => {
    cy.app('clean') // have a look at cypress/app_commands/clean.rb
  })

  it('setup basic scenario', function() {
    cy.appScenario('basic')
    cy.visit('/')
    cy.get('table').find('tbody').should(($tbody) => {
      // clean should of removed these from other tests
      expect($tbody).not.to.contain('Good bye Mars')
      expect($tbody).not.to.contain('Hello World')

      expect($tbody).to.contain('I am a Postman')
    })
  })


  it('example of missing scenario failure', function() {
    cy.visit('/')
    cy.appScenario('basic')
    // cy.appScenario('missing') // uncomment these if you want to see what happens
  })

  it('example of missing app failure', function() {
    cy.visit('/')
    cy.appScenario('basic')
    // cy.app('run_me') // uncomment these if you want to see what happens
  })
})

// 1. Login 
//    /
// 2. Login as Expert
//    /experts/login
// 3. .btn 
//    click
// 4. /experts/onboarding/welcome
//    .btn
// 5. Fill Up with "TestuserFirstname"
//    #expert_first_name
// 6. Fill Up with "TestuserLastname"
//    #expert_last_name
// 7. Fill Up with "richardsondx+testuser@gmail.com"
//    #expert_email
// 8. Select 'Toronto'
//    #expert_timezone_id
// 9. Toronto, ON, Canada 
//    #location
// 10. li first ( Unitesd State)
//    .selected-dial-code[0]
// 11. "612 345 5678"
//    #expert_contact_information_attributes_primary_mobile
// 12. li first ( Unitesd State)
//    .selected-dial-code[1]
// 13. "612 345 6789" 
//    #expert_contact_information_attributes_primary_phone
// 14. "Morning (8:00 - 11:00 AM)" 
//    #expert_contact_information_attributes_mobile_contact_time
// 15. "Morning (8:00 - 11:00 AM)" 
//    #expert_contact_information_attributes_phone_contact_time
// 16. Select File Upload
//     #profile_resume
// 17. Select service
//     #services_ids_
// 18. Select language
//    #languages_
// ----- Save First Degree
// 19. Fill up "Mathematics"
//     #education_history_field_of_study
// 20. Fill up "Mathematic B.S."
//     #education_history_degree
// 21. Fill up Institution Name "ASU"
//     #education_history_institution_name
// 22. 2018-01-12
//    #education_history_from_date
// 23. 2018-05-12
//    #education_history_to_date
// 25. Save
// ----- Save Second Degree
//    #save-work_industry
// 27. Fill up "History"
//     #education_history_field_of_study
// 28. Fill up "History B.S."
//     #education_history_degree
// 29. Fill up Institution Name "ASU"
//     #education_history_institution_name
// 30. 2018-03-12
//     #education_history_from_date
// 31. 2018-07-12
//     #education_history_to_date
// 32. Checked Present
//     #degree_present
// 33. Save
//     #save-work_industry