import React from 'react'
import ReactDOM from 'react-dom'

import FileUploader from '../components/FileUploader'
import App from '../components/App'
import Firebase, { FirebaseContext } from '../components/Firebase';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <FirebaseContext.Provider value={new Firebase()}>
      <App />
    </FirebaseContext.Provider>,
    // <FileUploader/>,
    document.body.appendChild(document.createElement('div')),
  )
})
