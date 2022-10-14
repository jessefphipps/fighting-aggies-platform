import React from 'react'
import ReactDOM from 'react-dom'

import FileUploader from '../components/FileUploader'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <FileUploader/>,
    document.body.appendChild(document.createElement('div')),
  )
})
