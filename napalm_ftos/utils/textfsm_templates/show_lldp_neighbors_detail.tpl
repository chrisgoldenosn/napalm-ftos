Value Filldown LOCAL_INTERFACE (.*)
Value REMOTE_CHASSIS_ID (.*)
Value REMOTE_PORT (.*)
Value REMOTE_PORT_DESCRIPTION (.+)
Value REMOTE_SYSTEM_NAME (.*)
Value REMOTE_SYSTEM_DESCRIPTION (.+)
Value REMOTE_SYSTEM_CAPAB (.*)
Value REMOTE_SYSTEM_ENABLE_CAPAB (.*)

Start
  # A line of ='s delimits neighbor records
  ^=======================+ -> Interface

Interface
  ^\s*Local Interface ${LOCAL_INTERFACE} has \d+ neighbors?
  ^\s*Remote Chassis ID Subtype: -> Neighbor

Neighbor
  ^\s*Remote Chassis ID:\s+${REMOTE_CHASSIS_ID}
  ^\s*Remote Port ID:\s+${REMOTE_PORT}
# The below are contextual and not always present.
  ^\s*Remote Port Description:\s+${REMOTE_PORT_DESCRIPTION} -> Continue
  ^\s*Remote System Name:\s+${REMOTE_SYSTEM_NAME} -> Continue
  ^\s*Remote System Desc: ${REMOTE_SYSTEM_DESCRIPTION} -> Continue
  ^\s*Existing System Capabilities:\s+${REMOTE_SYSTEM_CAPAB} -> Continue
  ^\s*Enabled System Capabilities:\s+${REMOTE_SYSTEM_ENABLE_CAPAB} -> Continue
  ^\s*-----------------------+ -> Record Interface