import * as React from 'react';
import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';

export default props => (
  
    <Card sx={{ minWidth: 275 }} style={{
          display: 'flex',
          alignItems: 'left',
          justifyContent: 'left',
      }}>
    <div className="bar" style={{
          display: 'flex',
          alignItems: 'left',
          justifyContent: 'left',
      }}>
      <CardContent>
        <Typography variant="h5" component="div">
          {props.block.data.name}
        </Typography>
        <Typography sx={{ mb: 1.5 }} color="text.secondary">
          {props.block.data.position}
        </Typography>
        <Typography variant="body2">
          RESULT:
          <br />
          {props.block.data.play_success}
        </Typography>
      </CardContent>
      <CardActions>
        <Button size="small">Learn More</Button>
      </CardActions>
      </div>
    </Card>
)