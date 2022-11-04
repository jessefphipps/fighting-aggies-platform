import FileUploader from "../../components/FileUploader/FileUploader"
import ReportSettings from "../../components/ReportSettings/ReportSettings"
import Results from "../../components/Results/Results"
import Export from "../../components/Export/Export"
import React, { Component }  from "react"
import { BrowserRouter as Router, Route, Link, Redirect } from 'react-router-dom';
import App from "../../components/App"
import { Box, createTheme, Stack, ThemeProvider, Grid, Paper} from "@mui/material";
import { styled } from '@mui/material/styles';



class Home extends Component {
  constructor(props) {
    super(props);
  }
  
  render() {
  
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
                      this.props.history.push('/');
                    }}>
                            Log Out
                    </button>
                  </div>} 
                <FileUploader />
              </UploaderTile>
              <ExportTile variant="elevation" elevation={8}>
                <Export/>
              </ExportTile>
            </Stack>
          </Grid>
          <Grid item xs={8}>
            <Stack direction="column" spacing={2}>
              <ReportTile variant="elevation" elevation={8}>
                <Results/>
              </ReportTile>
            </Stack>
          </Grid>
        </Grid>
      </Box>
    </div>
  );}
};

export default Home;