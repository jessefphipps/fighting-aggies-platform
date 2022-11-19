import React, {Component} from "react";
import ReactDOM from "react-dom";
import results_handler from "./results_handler.js";
import PropTypes from 'prop-types';
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';



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
      return (
        <div key={i}>
          <TabPanel value={value} index={i} key={i}>
            <div>
              {json_object.content[category].map((block) => results_handler(block))}
            </div>
          </TabPanel>
        </div>
        );
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
      }}>
        <Box sx={{ width: '100%', height: 800 }}>
          <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
            <Tabs value={value} onChange={handleChange} aria-label="basic tabs example">
              {TabBuilder(props.data)}
            </Tabs>
          </Box>
          <div style={{ height: 'inherit', overflow: 'auto' }}>
            {TabPanelBuilder(props.data, value)}
            </div>
        </Box>
      </div>
      );
  }
 
  export default Results;