import axios from 'axios';
 
import React,{Component} from 'react';

import Button from '@mui/material/Button';
 
class FileUploader extends Component {
  
    state = {
 
      // Initially, no file is selected
      selectedFile: null
    };
    
    // On file select (from the pop up)
    onFileChange = event => {
    
      // Update the state
      this.setState({ selectedFile: event.target.files[0] });
    
    };
    
    // On file upload (click the upload button)
    onFileUpload = (e) => {


    
      // Create an object of formData
      const formData = new FormData();
        e.preventDefault();
      // Update the formData object
      formData.append('data', this.state.selectedFile);
    
      // Details of the uploaded file
      console.log(this.state.selectedFile);
    
      // Request made to the backend api
      // Send formData object
      axios.post("/api/v1/videos/create", formData);
    };
    
    // File content to be displayed after
    // file upload is complete
    fileData = () => {
    
      if (this.state.selectedFile) {
         
        return (
          <div>
            <h2>File Details:</h2>
             
<p>File Name: {this.state.selectedFile.name}</p>

<p>File Size: {this.state.selectedFile.size} Bytes</p>
 
             
<p>
              Last Modified:{" "}
              {this.state.selectedFile.lastModifiedDate.toDateString()}
            </p>
 
          </div>
        );
      } else {
        return (
          <div>
            <br />
            <h4>Choose before Pressing the Upload button</h4>
          </div>
        );
      }
    };
    
    render() {
    
      return (
        <div>
            <h1>
              Fightin Aggies
            </h1>
            <h3>
              Upload File Here
            </h3>
            <div>
                <input type="file" onChange={this.onFileChange} />
                <button type="submit" onClick={this.onFileUpload}>
                  Upload!
                </button>
            </div>
          {this.fileData()}
        </div>
      );
    }
  }
 
  export default FileUploader;