import FileUploader from "../../components/FileUploader/FileUploader"
import ReportSettings from "../../components/ReportSettings/ReportSettings"
import Results from "../../components/Results/Results"
import Export from "../../components/Export/Export"
import React from "react"
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import App from "../../components/App"
import { Box, createTheme, Stack, ThemeProvider, Grid } from "@mui/material";

const Home = () => {
  return (
  <Box style={{ flex: 1  }} flexDirection="column">
    <Stack direction="row" spacing={2} bgcolor="skyblue" style={{ flex: 1  }}>
      <Stack direction="column" spacing={2} bgcolor="skyblue" justifyContent="space-around">
        <Box bgcolor="red" sx={{ flexGrow: 1 }}>
          <FileUploader />
        </Box>
        <Box bgcolor="red" sx={{ flexGrow: 4 }}>
          <ReportSettings />
        </Box>
      </Stack>
      <Stack direction="column" spacing={2} bgcolor="skyblue" justifyContent="space-around">
        <Box bgcolor="red" sx={{ flexGrow: 1 }}>
          <Results />
        </Box>
        <Box bgcolor="red" sx={{ flexGrow: 1 }}>
          <Export />
        </Box>
      </Stack>
    </Stack>
  </Box>
  );
};

export default Home;