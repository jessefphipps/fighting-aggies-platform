import React,{Component} from 'react';

import Button from '@mui/material/Button';

import {CSVLink, CSVDownload} from 'react-csv';

import axios from 'axios';
 
class Export extends Component {
  constructor(props) {
    super(props);
    this.download = this.download.bind(this);
    this.state = {
      data: [],
      error: false
    }
  }
  
  // componentWillReceiveProps(nextProps) {
  //   this.setState({data: nextProps.data});
  // }
  
  // log = () => {
  //   console.log(this.props.data);
  // };
  
  download(event) {
    // var testData = [
    //       { name: "ramesh", age: "12" },
    //       { name: "bill", age: "13" },
    //       { name: "arun", age: "9" },
    //       { name: "kathy", age: "21" },
    //     ];
    // this.setState({ data: testData}, () => {
    //   // click the CSVLink component to trigger the CSV download
    //   this.csvLink.link.click();
    // });
    // var selectedVideoId = sessionStorage.get('');
//     {
//     "home_team": "Texas A&M",
//     "away_team": "Alabama",
//     "home_score": 14,
//     "away_score": 18,
//     "quarter": 4,
//     "play_down": 3,
//     "yard_to_10": 10,
//     "play_type": "pass",
//     "play_name": "PA Y-Cross",
//     "play_success": 1,
//     "received_by": "Devon Achane",
//     "yards_gained": 2,
//     "QB_name": "Conner Weigman",
//     "WR1_name": "Devon Achane",
//     "WR1_route": "Fly",
//     "WR1_good_route": 0,
//     "WR2_name": "Max Wright",
//     "WR2_route": "Fly",
//     "WR2_good_route": 1,
//     "TE_name": "Evan Stewart",
//     "TE_route": "Fly",
//     "TE_good_route": 0,
//     "RB_name": "Ainias Smith",
//     "RB_route": "Fade",
//     "RB_good_route": 1
// }
    var id = sessionStorage.getItem('reportId');
    var analysisId = sessionStorage.getItem('analysisId');
    console.log(analysisId);
    axios.get('/api/v1/visions/show?id=' + id).then((dataJson) => {
        this.setState({error: false});
        // console.log(dataJson);
        const report = dataJson.data.report;
        // console.log(report);
        // console.log(typeof report);
        const parsedReport = JSON.parse(report);
        console.log(typeof parsedReport);
        console.log(parsedReport);
        console.log(parsedReport.home_team);
        const arr = []
        Object.keys(parsedReport).forEach(key => arr.push({name: key, value: parsedReport[key]}));
// Object.keys(parsedReport).forEach(key => arr.push({name: key, value: parsedReport[key]}));
        // console.log(arr[0].name, arr[0].value);
        console.log(arr);
        this.setState({
          data: arr,
        }, () => {
          // click the CSVLink component to trigger the CSV download
          this.csvLink.link.click();
        });
      }).catch((e) => {
        this.setState({data: [], error: true});
        console.log(e);
      });
    console.log(111);
  };
  
  createVision() {
    var id = sessionStorage.getItem('videoId');
    axios.post('/api/v1/visions/create', {id : id}).then((response) => {
        console.log(response);
        sessionStorage.setItem('reportId', response.data.id);
      }).catch((e) => {
        console.log(e);
      });
  }
    
    render() {
    
      return (
        <div>
          <div className="export-div">
            {/*<Button onClick={this.createVision}>Create</Button>*/}
            <Button variant="contained" onClick={this.download}>Export csv</Button>
            <CSVLink
              data={this.state.data}
              filename="report.csv"
              className="hidden"
              ref={(r) => (this.csvLink = r)}
              target="_blank"
            />
            <div className="export-error-message">
              {this.state.error ? 'something went wrong...' : ''}
            </div>
          </div>
        </div>
      );
    }
  }

 
export default Export;