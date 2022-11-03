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
        title: "test",
      },
      {
        _uid: "BUY6Drn9e5",
        component: "barchart",
        headline: "bar",
        title: "tes2",
      }
      ]
    },
    offense: {
      figures: [
      {
        _uid: "BUY6Drn9e1",
        component: "barchart",
        headline: "bar",
        title: "test3",
      },
      {
        _uid: "BUY6Drn9e5",
        component: "barchart",
        headline: "bar",
        title: "test4",
      }
      ]
    },
    defense: {
      figures: [
      {
        _uid: "BUY6Drn9e1",
        component: "barchart",
        headline: "bar",
        title: "test4",
      },
      {
        _uid: "BUY6Drn9e5",
        component: "barchart",
        headline: "bar",
        title: "test5",
      }
      ]
    }
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