describe('User Login', function () {
  it('Success Login', () => {
    cy.visit('http://localhost:3000/login')
    cy.get('#username').type('admin@example.com')
    cy.get('#password').type('123456')
    cy.get('#login-button').click()
    cy.url().should('contains','success')
  })

  it('Unsuccessful Login - Invaild Email', () => {
    cy.visit('http://localhost:3000/login')
    cy.get('#username').type('admin')
    cy.get('#password').type('123456')
    cy.get('#login-button').click()
    cy.get('#error-message').should('have.text','Firebase: The email address is badly formatted. (auth/invalid-email).')
  })

  it('Unsuccessful Login - Invaild Password', () => {
    cy.visit('http://localhost:3000/login')
    cy.get('#username').type('admin@example.com')
    cy.get('#password').type('12345678')
    cy.get('#login-button').click()
    cy.get('#error-message').should('have.text','Firebase: The password is invalid or the user does not have a password. (auth/wrong-password).')
  })
})

// Feature: User Login
//     User should be able to login

// Scenario: Correct email and password provided
//     Given the user is on the login page
//     Given the user provides correct email and password
//     When they click on the login button
//     Then they should be redirected to the success page

// Scenario: Incorrect email or password provided
//     Given the User is on the login page
//     Given the User provides invalid email or password
//     When they click on the login button
//     Then they should get a negative feedback