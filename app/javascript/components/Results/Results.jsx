import React, {Component} from "react";
import ReactDOM from "react-dom";
import results_handler from "./results_handler.js";
import PropTypes from 'prop-types';
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';

const data = {
  content: {
    overview: {
      figures: [
      {
        _uid: "BUY6Drn9e1",
        component: "barchart",
        headline: "bar",
        title: "Performance by group - Offense",
        data: [
          {
            "name": "Receivers",
            "1st": 4000,
            "2nd": 2400,
          },
          {
            "name": "QB",
            "1st": 5000,
          },
          {
            "name": "Running Backs",
            "1st": 2000,
            "2nd": 1500,
          },
          {
            "name": "Tight Ends",
            "1st": 2780,
            "2nd": 2900,
          },
          {
            "name": "O-Line",
            "1st": 8000,
            "2nd": 3312,
          },
        ]
      },
      {
        _uid: "BUY6Drn9ade1",
        component: "barchart",
        headline: "bar",
        title: "Performance by group - Defense",
        data: [
          {
            "name": "D-Line",
            "1st": 6000,
            "2nd": 2400,
          },
          {
            "name": "LB",
            "1st": 5000,
            "2nd": 6500,
          },
          {
            "name": "Safety",
            "1st": 1313,
            "2nd": 2251,
          },
          {
            "name": "Corners",
            "1st": 6251,
            "2nd": 4361,
          },
        ]
      }
      ]
    },
  }
};

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
          <TabPanel value={value} index={i} key={i}>
            <div>
              {data.content[category].figures.map((block) => results_handler(block))}
            </div>
          </TabPanel>
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


function Results () {
  
  
  const [value, setValue] = React.useState(0);
    
  const handleChange = (event, newValue) => {
    setValue(newValue);
  };
    
  

      
      
      return (
      <Box sx={{ width: '100%' }}>
        <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
          <Tabs value={value} onChange={handleChange} aria-label="basic tabs example">
            {TabBuilder(data)}
          </Tabs>
        </Box>
        {TabPanelBuilder(data, value)}
      </Box>
      );
  }
 
  export default Results;
  
  
  // <div>
  //           {data.content[this.state.currentCategory].figures.map((block) => results_handler(block))}
  //       </div>