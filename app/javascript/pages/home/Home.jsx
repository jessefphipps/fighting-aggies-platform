import FileUploader from "../../components/FileUploader/FileUploader"
import ReportSettings from "../../components/ReportSettings/ReportSettings"
import Results from "../../components/Results/Results"
import Export from "../../components/Export/Export"
import React, { Component }  from "react"
import { BrowserRouter as Router, Route, Link, Redirect } from 'react-router-dom';
import App from "../../components/App"
import { Box, createTheme, Stack, ThemeProvider, Grid, Paper} from "@mui/material";
import { styled } from '@mui/material/styles';
import Button from '@mui/material/Button';
import axios from 'axios';

import { resultsAtom } from '../../recoil/atoms/resultsAtom';
import { uploadedFileAtom } from '../../recoil/atoms/uploadedFileAtom';
import { selectedFileAtom } from '../../recoil/atoms/selectedFileAtom';

import { useHistory } from "react-router";

import {
  useRecoilState,
} from 'recoil';

function getRandomSubarray(arr, size) {
    var shuffled = arr.slice(0), i = arr.length, temp, index;
    while (i--) {
        index = Math.floor((i + 1) * Math.random());
        temp = shuffled[index];
        shuffled[index] = shuffled[i];
        shuffled[i] = temp;
    }
    return shuffled.slice(0, size);
}


function generate_random_report(){
        const report = {
            'Offense': [{
                'component': 'piechart',
                'title': 'Point Distribution',
                'data': [{
                    'name': 'Passing Touchdown Points',
                    'value': getRandomSubarray([6,12,18,24,30], 1)[0]
                },
                {
                    'name': 'Rushing Touchdown Points',
                    'value': getRandomSubarray([6,12,18,24,30], 1)[0]
                },
                {
                    'name': 'Field Goal Points',
                    'value': getRandomSubarray([3,6,9,12,15,18,21], 1)[0]
                },
                {
                    'name': 'Extra Points',
                    'value': getRandomSubarray([1,2,3,4,5], 1)[0]
                }],
            }, {
                'component': 'barchart',
                'title': 'Yards Gained per Play Type',
                'data': [{
                    'name': 'Passing',
                    'value': getRandomSubarray([312, 412, 132], 1)[0]
                },
                {
                    'name': 'Rushing',
                    'value': getRandomSubarray([221, 86, 211], 1)[0]
                }]
            }],
            'Defense': [{
                'component': 'barchart',
                'title': 'Yards Allowed per Play Type',
                'data': [{
                    'name': 'Passing',
                    'value': getRandomSubarray([123, 333, 211], 1)[0]
                },{
                    'name': 'Rushing',
                    'value': getRandomSubarray([42, 442, 86], 1)[0]
                }]
            },{
                'component': 'piechart',
                'title': 'Successful Defensive Plays',
                'data': [{
                    'name': 'Blitz',
                    'value': getRandomSubarray([12, 15, 24], 1)[0]
                },
                {
                    'name': 'Man Coverage',
                    'value': getRandomSubarray([8, 16, 22], 1)[0]
                },
                {
                    'name': 'Zonal Coverage',
                    'value': getRandomSubarray([12, 14, 11], 1)[0]
                }]
            }]
        }
        
        return report;
}



function  Home () {
  
  
const [uploadedFile, setuploadedFile] = useRecoilState(uploadedFileAtom);
const [results, setResults] = useRecoilState(resultsAtom);
const [selectedFile, setSelectedFile] = useRecoilState(selectedFileAtom);

const generateReport = (event) => {
  // axios.post("/api/v1/analyses/create", {'id': uploadedFile['id']}).then((response)=>{
  //   const report = JSON.parse(response.data.report);
  //   setResults({
  //     content: report,
  //   })
  //   setuploadedFile(false)
  //   setSelectedFile(null)
  // }).catch((error) => {
  //     // handle error
  //     console.log(error.errormessage);
  //   });
    console.log(generate_random_report())
    setResults({
      content: generate_random_report(),
    })
    setuploadedFile(false)
    setSelectedFile(null)
  };
  
// const fetchResults = (event) => {
//   axios.post("/api/v1/analyses/create", {'id': 1}).then((response)=>{
//     console.log(response)
//       this.setState({
//       fileUploaded: true,
//       results: {content: JSON.parse(response.data.report)},
//     }).catch((error) => {
//       // handle error
//       console.log(error.errormessage);
//     });
//   })
// };

const UploaderTile = styled(Paper)(({ theme }) => ({
  backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
  ...theme.typography.body2,
  padding: theme.spacing(1),
  textAlign: 'center',
  color: theme.palette.text.secondary,
  height: "50vh"
}));

const ReportTile = styled(Paper)(({ theme }) => ({
  backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
  ...theme.typography.body2,
  padding: theme.spacing(1),
  textAlign: 'center',
  color: theme.palette.text.secondary,
  height: "93vh"
}));

const ExportTile = styled(Paper)(({ theme }) => ({
  backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
  ...theme.typography.body2,
  padding: theme.spacing(1),
  textAlign: 'center',
  color: theme.palette.text.secondary,
  height: "40vh"
}));

const user = sessionStorage.getItem('user');

const history = useHistory();

// console.log('UploadedFile: ', uploadedFile)

if (user == null) return <Redirect to='/' />
return (
    <div style={{padding: '10px'}}>
      <Box sx={{ flexGrow: 1 }}>
        <Grid container spacing={2}>
          <Grid item xs={4}>
            <Stack direction="column" spacing={2}>
              <UploaderTile variant="elevation" elevation={8}>
                {user && 
                  <div>
                    <span id='login_user'> {user} </span>
                    <button id='logout-button' onClick = { () => {
                      sessionStorage.removeItem('user');
                      history.push('/');
                    }}>
                            Log Out
                    </button>
                  </div>} 
                <FileUploader/>
                <Button variant="contained" onClick={generateReport} disabled={!uploadedFile} id="fetch_results_button">
                  Generate Report
                </Button>
              </UploaderTile>
              <ExportTile variant="elevation" elevation={8}>
                <Export />
              </ExportTile>
            </Stack>
          </Grid>
          <Grid item xs={8}>
            <Stack direction="column" spacing={2}>
              <ReportTile variant="elevation" elevation={8}>
                <Results data={results}/>
              </ReportTile>
            </Stack>
          </Grid>
        </Grid>
      </Box>
    </div>
  );
};

export default Home;