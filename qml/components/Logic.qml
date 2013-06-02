


import QtQuick 1.0

import "../js/constants.js" as Constants
import "../js/sounds.js" as Sounds



QtObject {
    
    
    
    function playRandomSound()
    {
        var n = Math.floor( Sounds.sounds.length * Math.random());
        
        var file = Sounds.sounds[n].file
        sound.play(file);

        app.burstParticles();
    }
    // ----------------------------------------------------------------
    // UI logic
    // ----------------------------------------------------------------
    property variant indexMap: [ "menu", "free", "timed", "movement", "about"];
    
    function setPage(index)
    {
        //        console.log("INDEX IN", index, "STATE", state)
        
        if(app.state != indexMap[index]) {
            app.state = indexMap[index];
            mv.showPage(index);
            //            console.log("INDEX *SET*", index, "STATE", state)
            
            if(app.state == "play") {
                // TODO
            }
            
            return;
        }
        //        console.log("INDEX OUT", index, "STATE", state)        
    }
}
