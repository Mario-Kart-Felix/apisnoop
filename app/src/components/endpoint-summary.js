import React from 'react'

import EndpointCategories from './endpoint-categories'

const EndpointSummary = (props) => {
  const {
    endpoint
  } = props

  if (endpoint == null) return null
  console.log({endpoint})
  return (
    <div id='endpoint-summary'>
      <EndpointCategories endpoint={endpoint}/>
    </div>
  )
}

export default EndpointSummary
