import FileUploader from "../../components/FileUploader/FileUploader"
import ReportSettings from "../../components/ReportSettings/ReportSettings"
import Results from "../../components/Results/Results"
import Export from "../../components/Export/Export"
import React from "react"
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import App from "../../components/App"
import { Box, createTheme, Stack, ThemeProvider, Grid, Paper} from "@mui/material";
import { styled } from '@mui/material/styles';



const Home = () => {
  
  const UploaderTile = styled(Paper)(({ theme }) => ({
    backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
    ...theme.typography.body2,
    padding: theme.spacing(1),
    textAlign: 'center',
    color: theme.palette.text.secondary,
    height: "50vh"
  }));
  
  const SettingsTile = styled(Paper)(({ theme }) => ({
    backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
    ...theme.typography.body2,
    padding: theme.spacing(1),
    textAlign: 'center',
    color: theme.palette.text.secondary,
    height: "40vh"
  }));
  
  const ReportTile = styled(Paper)(({ theme }) => ({
    backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
    ...theme.typography.body2,
    padding: theme.spacing(1),
    textAlign: 'center',
    color: theme.palette.text.secondary,
    height: "60vh"
  }));
  
  const ExportTile = styled(Paper)(({ theme }) => ({
    backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
    ...theme.typography.body2,
    padding: theme.spacing(1),
    textAlign: 'center',
    color: theme.palette.text.secondary,
    height: "30vh"
  }));
  
  
  return (

  <Box sx={{ flexGrow: 1 }}>
      <Grid container spacing={2}>
        <Grid item xs={4}>
          <Stack direction="column" spacing={2}>
            <UploaderTile variant="elevation" elevation={8}>
              <FileUploader />
            </UploaderTile>
            <SettingsTile variant="elevation" elevation={8}>
              <ReportSettings />
            </SettingsTile>
          </Stack>
        </Grid>
        <Grid item xs={8}>
          <Stack direction="column" spacing={2}>
            <ReportTile variant="elevation" elevation={8}>
              <Results/>
            </ReportTile>
            <ExportTile variant="elevation" elevation={8}>
              <Export/>
            </ExportTile>
          </Stack>
        </Grid>
      </Grid>
    </Box>
  );
};

export default Home;