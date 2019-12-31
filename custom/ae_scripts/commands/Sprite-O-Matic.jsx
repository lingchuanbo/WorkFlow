// Sprite-O-Matic (version 1.0)
// Dillon Becker, 2015 (dillonbecker.com)

// DESCRIPTION: Sprite-O-Matic helps editors animate sprite sheets in After Effects.
// INSTRUCTIONS: Select your sprite sheet, input the number of rows and columns (additional inputs are optional) and click Animate! A new comp will be created containing your animated sprite.
// NOTES: Sprite-O-Matic assumes sprite sheets are equally sized and spaced. Uneven frame counts can be overridden using the "# of Frames" field.

function db_SpriteOMatic(t) {
    function e(t) {
        function e() {
            if (0 == app.project.selection.length) return void alert("Please select a sprite sheet from your project files or comp.");
            var t = parseInt(n.grp.groupCols.colsNum.text, 10),
                e = parseInt(n.grp.groupRows.rowsNum.text, 10),
                r = parseInt(n.grp.groupFrames.framesNum.text, 10),
                
                o = parseInt(n.grp.groupLength.frameLength.text, 10),
                a = parseInt(n.grp.groupFPS.fpsNum.text, 10),
                p = parseInt(n.grp.groupIt.itNum.text, 10);
            app.beginUndoGroup("Sprite-O-Matic");
            var s = app.project.activeItem;
            if (!(s instanceof FootageItem || s instanceof CompItem)) return void alert("Please select a sprite sheet from your project files or comp.");
            if (!(t > 0)) return void alert("Please enter the number of Columns.");
            if (!(e > 0)) return void alert("Please enter the number of Rows.");
            r > 0 || (n.grp.groupFrames.framesNum.text = e * t), o > 0 || (n.grp.groupLength.frameLength.text = 1), a > 0 || (n.grp.groupFPS.fpsNum.text = 15), p > 0 || (n.grp.groupIt.itNum.text = 1);
            var u = Math.round(s.width / t),
                l = Math.round(s.height / e),
                g = app.project.items.addComp(s.name + " Animation", u, l, 1, r / a * o * p, a),
                m = 0;
            for (i = 1; p >= i; i++) {
                var h = 1,
                    c = 0,
                    x = s.width / 2,
                    d = s.height / 2;
                for (f = 1; r >= f; f++) {
                    var w = g.layers.add(s, o / a);
                    w.startTime = m / a, w.transform.position.setValue([x, d]), x -= u, m += 1 * o, t > h ? h++ : (x = s.width / 2, d -= l, h = 1, c++)
                }
            }
            app.endUndoGroup()
        }
        if (t instanceof Panel) var n = t;
        else var n = t instanceof Panel ? t : new Window("palette", r, void 0, {
            resizeable: !0
        });
        if (null != n) {
            var a = "group{orientation:'column', alignment:['left','top']                            groupCols: Group{orientation: 'row', alignment:['fill','fill'], alignChildren:['left','top'],                                colsLabel: StaticText{text:'# of Cols 列:'},                                colsNum: EditText{characters: 3, text:''},                            },                           groupRows: Group{orientation: 'row', alignment:['fill','fill'], alignChildren:['left','top'],                                rowsLabel: StaticText{text:'# of Rows 行:'},                                rowsNum: EditText{characters: 3, text:''},                            },                            groupFrames: Group{orientation: 'row', alignment:['fill','fill'], alignChildren:['left','top'],                                framesLabel: StaticText{text:'# of Frames 帧 :'},                                framesNum: EditText{characters: , text:''},                            },                            groupLength: Group{orientation: 'row', alignment:['fill','fill'], alignChildren:['left','top'],                                lengthLabel: StaticText{text:'Frame Length帧长度:'},                                frameLength: EditText{characters: 3, text:'1'},                            },                            groupFPS: Group{orientation: 'row', alignment:['fill','fill'], alignChildren:['left','top'],                                fpsLabel: StaticText{text:'FPS合成帧率:'},                                fpsNum: EditText{characters: 3, text:'15'},                            },                            groupIt: Group{orientation: 'row', alignment:['fill','fill'], alignChildren:['left','top'],                                itLabel: StaticText{text:'Iterations迭代:'},                                itNum: EditText{characters: 3, text:'1'},                            },                            groupButtons: Group{orientation: 'row', alignment:['fill','fill'], alignChildren:['left','top'],                                animateButton: Button{text:'Animate!'},                                helpButton: Button{text:'?'},                            },                 }";
            n.grp = n.add(a), n.grp.groupCols.colsLabel.minimumSize.width = 80, n.grp.groupRows.rowsLabel.minimumSize.width = 80, n.grp.groupFrames.framesLabel.minimumSize.width = 80, n.grp.groupLength.lengthLabel.minimumSize.width = 80, n.grp.groupFPS.fpsLabel.minimumSize.width = 80, n.grp.groupIt.itLabel.minimumSize.width = 80, n.grp.groupButtons.helpButton.preferredSize.width = 20, n.grp.groupCols.colsNum.onChange = function () {
                n.grp.groupFrames.framesNum.text = n.grp.groupCols.colsNum.text * n.grp.groupRows.rowsNum.text
            }, n.grp.groupRows.rowsNum.onChange = function () {
                n.grp.groupFrames.framesNum.text = n.grp.groupCols.colsNum.text * n.grp.groupRows.rowsNum.text
            }, n.grp.groupCols.colsNum.onChanging = function () {
                this.text.match(/[^\d]/) && (this.text = this.text.replace(/[^\d]/g, ""))
            }, n.grp.groupRows.rowsNum.onChanging = function () {
                this.text.match(/[^\d]/) && (this.text = this.text.replace(/[^\d]/g, ""))
            }, n.grp.groupFrames.framesNum.onChanging = function () {
                this.text.match(/[^\d]/) && (this.text = this.text.replace(/[^\d]/g, ""))
            }, n.grp.groupLength.frameLength.onChanging = function () {
                this.text.match(/[^\d]/) && (this.text = this.text.replace(/[^\d]/g, ""))
            }, n.grp.groupFPS.fpsNum.onChanging = function () {
                this.text.match(/[^\d]/) && (this.text = this.text.replace(/[^\d]/g, ""))
            }, n.grp.groupIt.itNum.onChanging = function () {
                this.text.match(/[^\d]/) && (this.text = this.text.replace(/[^\d]/g, ""))
            }, n.grp.groupButtons.animateButton.onClick = function () {
                e()
            }, n.grp.groupButtons.helpButton.onClick = function () {
                alert(r + " (v." + o + ")\n\n# of Cols: The number of columns in your sprite sheet.\n\n# of Rows: The number of rows in your sprite sheet.\n\n# of Frames: The total number of frames in your sprite sheet.\n\nFrame Length: This determines the frame duration of each sprite in the animation comp.\n\nFPS: This sets the FPS for the animation comp.\n\nIterations: How many times you want to loop the animation within the animation comp.")
            }, n.layout.layout(!0), n.layout.resize(), n.onResizing = n.onResize = function () {
                this.layout.resize()
            }
        }
        return n
    }
    var r = "切图动画",
        o = "1.0",
        n = e(t);
    null != n && n instanceof Window && (n.center(), n.show())
}
db_SpriteOMatic(this);