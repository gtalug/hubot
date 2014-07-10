# Description:
#   Get information about GTALUG from the GTALUG web site.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   upcoming meeting - Show the upcoming GTALUG meeting.
#
# TODO Commands:
#   code of conduct - Display the GTALUG code of conduct.
#   meeting location - Display where the GTALUG meeting is happening.
#
# Author:
#   myles

module.exports = (robot) ->
    
    robot.hear 'upcoming meeting', (msg) ->
        
        msg.http('http://gtalug.org/api/upcoming_meeting.json')
            .get() (err, res, body) ->
                
                if err
                    msg.send "GTALUG.org says: #{err}"
                    return
                
                content = JSON.parse(body)
                
                if content.meta.status isnt 200
                    msg.send "GTALUG.org failed"
                    return
                
                msg.send "#{content.date} - #{content.title}"
                msg.send "#{content.url}"