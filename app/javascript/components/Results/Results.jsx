import React, {Component} from "react";
import ReactDOM from "react-dom";
import results_handler from "./results_handler.js";
import PropTypes from 'prop-types';
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import {createTheme, Stack, ThemeProvider, Grid, Paper} from "@mui/material";



function TabPanel(props) {
  const { children, value, index, ...other } = props;

  return (
    <div
      role="tabpanel"
      hidden={value !== index}
      id={`simple-tabpanel-${index}`}
      aria-labelledby={`simple-tab-${index}`}
      {...other}
    >
      {value === index && (
        <Box sx={{ p: 3 }}>
          <Typography component={'div'} >{children}</Typography>
        </Box>
      )}
    </div>
  );
}

function TabBuilder(json_object){
  return Object.keys(json_object.content).map((category, i)=>{
    return <Tab label={category} key={i} {...a11yProps(i)} />
  })
}

function TabPanelBuilder(json_object, value){
  return Object.keys(json_object.content).map((category, i)=>{
    if (category == "Players"){
      let list_of_blocks = [...json_object.content[category]]
      return (
        <div key={i}>
          <TabPanel value={value} index={i} key={i}>
            <div name="tab_results">
              {list_of_blocks.sort((a,b) => a["data"]["play_success_rate"] - b["data"]["play_success_rate"]).map((block) => results_handler(block))}
            </div>
          </TabPanel>
        </div>
        );
    } else {
      return (
        <div key={i}>
          <TabPanel value={value} index={i} key={i}>
            <div name="tab_results">
              {json_object.content[category].map((block) => results_handler(block))}
            </div>
          </TabPanel>
        </div>
        );
    }
      
    });
}

TabPanel.propTypes = {
  children: PropTypes.node,
  index: PropTypes.number.isRequired,
  value: PropTypes.number.isRequired,
};

function a11yProps(index) {
  return {
    id: `simple-tab-${index}`,
    'aria-controls': `simple-tabpanel-${index}`,
  };
}

function getReport(){
  
}


const Results = (props) => {

  const [value, setValue] = React.useState(0);
    
  const handleChange = (event, newValue) => {
    setValue(newValue);
  };
  
  
  
  return (
      <div style={{
          display: 'flex',
          alignItems: 'left',
          justifyContent: 'left',
          height: "100%",
      }}>
      <Stack sx={{height: "100%", width:"100%"}}>
          <Box sx={{ width: '100%'}}>
            <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
              <Tabs value={value} onChange={handleChange} aria-label="basic tabs example">
                {TabBuilder(props.data)}
              </Tabs>
            </Box>
          </Box>
          <Box sx={{overflowY:"scroll", height:"100%"}}>
            {TabPanelBuilder(props.data, value)}
          </Box>
        </Stack>
      </div>
      );
  }
 
  export default Results;