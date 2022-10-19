import app from 'firebase/compat/app';
import 'firebase/compat/auth';

const config = {
    apiKey: "AIzaSyD1o5xsH4yn1ZDJqVd1bsw9B_OF2x1N-po",
    authDomain: "fightin-aggies.firebaseapp.com",
    projectId: "fightin-aggies",
    storageBucket: "fightin-aggies.appspot.com",
    messagingSenderId: "16096242159",
    appId: "1:16096242159:web:1a309057134380b2f9ae1a",
    measurementId: "G-YDGWMSF9BB"
};

class Firebase {
    constructor() {
        app.initializeApp(config);

        this.auth = app.auth();
    }

    // *** Auth API ***
    // doCreateUserWithEmailAndPassword = (email, password) =>
    //     this.auth.createUserWithEmailAndPassword(email, password);

    doSignInWithEmailAndPassword = (email, password) =>
        this.auth.signInWithEmailAndPassword(email, password);

    doSignOut = () => this.auth.signOut();

    // doPasswordReset = email => this.auth.sendPasswordResetEmail(email);

    // doPasswordUpdate = password =>
    //   this.auth.currentUser.updatePassword(password);
}

export default Firebase;