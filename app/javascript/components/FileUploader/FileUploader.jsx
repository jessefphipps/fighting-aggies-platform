import axios from 'axios';
 
import React,{Component} from 'react';

import Button from '@mui/material/Button';
import LinearProgress from '@mui/material/LinearProgress';

import { Box, createTheme, Stack, ThemeProvider, Grid } from "@mui/material";
 
class FileUploader extends Component {
  
    state = {
      // Initially, no file is selected
      selectedFile: null,
      uploadedFile: null,
      errors: null,
      progress: 0,
    };
    
    allowed_exts = new Set(['avi', 'flv', 'mkv', 'mov', 'mp4']);
    
    // On file select (from the pop up)
    onFileChange = event => {
      
      // Check for file extension
      const filename = event.target.files[0].name;
      const ext = filename.split('.').pop();
      if (!this.allowed_exts.has(ext)){
        // Update the state with errors
        this.setState({ selectedFile: null, 
                      uploadedFile: null, 
                      errors: "selected file type is not supported. Try again."});
        return;
      }
    
      // Update the state with correct file
      this.setState({ selectedFile: event.target.files[0], 
                      uploadedFile: null, 
                      errors: null,
                      progress: 0});
    };
    
    // On file upload (click the upload button)
    onFileUpload = (e) => {
      
      // Only move forward if video file is selected
      if (!this.state.selectedFile){
        return;
      }
      
      // Create an object of formData
      const formData = new FormData();
      e.preventDefault();
      // Update the formData object
      formData.append('data', this.state.selectedFile);
    
      // Details of the uploaded file
      console.log(this.state.selectedFile);
      
      const successHandler = response => this.setState({
        selectedFile: this.state.selectedFile,
        uploadedFile: response.data,
        errors: null,
        progress: this.state.progress,
      });
      
      const errorHandler = error => this.setState({
        selectedFile: this.state.selectedFile,
        uploadedFile: null,
        errors: error.data.errormessage,
        progress: this.state.progress,
      });
      
      const setProgress = progress => this.setState({
        selectedFile: this.state.selectedFile,
        uploadedFile: null,
        errors: null,
        progress: progress,
      });
    
      // Request made to the backend api
      // Send formData object
      axios.post("/api/v1/videos/create", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
        onUploadProgress: (progressEvent) => {
          const progress = (progressEvent.loaded / progressEvent.total) * 100;
          setProgress(progress);
        }}
      )
      .then((response) => {
        // handle success
        console.log(response);
        successHandler(response);
        
        // call nested GET request to request reports
        // axios.get("/api/v1/videos/index") // Dummy request to validate it for now
        // .then((response) => {
        //   console.log(response);
        // })
        // .catch((error) => {
        //   // handle error
        //   console.log(error);
        // });
      })
      .catch((error) => {
        // handle error
        console.log(error);
        errorHandler(error.response);
      });

    };
    
    // File content to be displayed after
    // file upload is complete
    fileData = () => {
      
      // Show selection errors to the user
      if (!this.state.selectedFile && this.state.errors){
        return (
          <div>
            <br />
            <h4>Incorrect file type</h4>
            <p id="select_error">Error: {this.state.errors}</p>
          </div>
        );
      }
      
      // Show upload errors to the user
      if (this.state.selectedFile && this.state.errors){
        return (
          <div>
            <br />
            <h4>Upload failed</h4>
            <p id="upload_error">Error: {this.state.errors}</p>
          </div>
        );
      }
      
      // Selected file, but hasn't successfully uploaded it yet
      if (this.state.selectedFile && !this.state.uploadedFile) {
        return (
          <div>
            <br />
            <p>Selected file: {this.state.selectedFile.name}</p>
            <h4>Click the upload button to proceed</h4>
          </div>
        );
      }
      
      // File has been uploaded
      if (this.state.selectedFile && this.state.uploadedFile){
        this.props.fileSuccessHandler();
        return (
          <div>
            <h4 id="file_details">Uploaded File Details:</h4>
            <ul style={{'listStyle' : 'none', 'padding': 0}}>
              <li>Name: {this.state.selectedFile.name}</li>
              <li>Size: {this.state.selectedFile.size} bytes</li>
              <li>Resolution: {this.state.uploadedFile.resolution} px</li>
              <li>Duration: {this.state.uploadedFile.duration} seconds</li>
              <li>Frame rate: {this.state.uploadedFile.frame_rate} fps</li>
            </ul>
          </div>
        );
      }
      
      
      // No file selected (nor uploaded)
      return (
          <div>
            <br />
            <h4>Choose a video file</h4>
          </div>
      );
    };
    
    render() {
    
      return (
        <div>
            <h1>
              Fightin Aggies Analytics Platform
            </h1>
            <Stack direction="row" spacing={2}  style={{ flex: 1  }} justifyContent="space-around">
                <Button
                  variant="contained"
                  component="label"
                >
                  Select Video File
                  <input
                    id="file_select_button"
                    type="file"
                    hidden
                    onChange={this.onFileChange}
                  />
                </Button>
                <Button variant="contained" onClick={this.onFileUpload} disabled={!this.state.selectedFile} id="file_upload_button">
                  Upload
                </Button>
            </Stack>
            <LinearProgress variant="determinate" value={this.state.progress} />
                
          {this.fileData()}
        </div>
      );
    }
  }
 
  export default FileUploader;