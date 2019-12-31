function goThroughAllPropertiesAndEnableExpressions(propertyGroup) {
    for (var i = 1; i <= propertyGroup.numProperties; i += 1) {
        property = propertyGroup.property(i);
        if (property.propertyType === PropertyType.PROPERTY) {
            if (property.canSetExpression === true && property.expression !== "") {
                property.expressionEnabled = true;
            }
        } else {
            goThroughAllPropertiesAndEnableExpressions(property);
        }
    }
}
function goThroughAllPropertiesAndDeleteKeys(propertyGroup) {
    for (var i = 1; i <= propertyGroup.numProperties; i += 1) {
        property = propertyGroup.property(i);
        if (property.propertyType === PropertyType.PROPERTY) {
            if (property.canVaryOverTime && property.isTimeVarying && property.matchName !== "ADBE Marker") {
                var activeItem = app.project.activeItem;
                var numKeys = property.numKeys;
                var currentValue = property.valueAtTime(activeItem.time, true);
                for (var u = 0; u < numKeys; u += 1) {
                    property.removeKey(1);
                }
                if (property.dimensionsSeparated !== true) {
                    try {
                        property.setValue(currentValue);
                    } catch (error) {

                    }
                }
            }
        } else {
            goThroughAllPropertiesAndDeleteKeys(property);
        }
    }
}

function deleteAllEffectsFromLayer(layer) {
            if (!(layer instanceof LightLayer || layer instanceof CameraLayer)) {
                for (var i = layer.property("ADBE Effect Parade").numProperties; i > 0; i--) {
                    layer.property("ADBE Effect Parade").property(1).remove();
                }
            }
        }
    
function deleteAllMasksFromLayer(layer) {
            if (!(layer instanceof LightLayer || layer instanceof CameraLayer)) {
                for (var i = layer.property("ADBE Mask Parade").numProperties; i > 0; i--) {
                    layer.property("ADBE Mask Parade").property(1).remove();
                }
            }
        }
function deleteAllMarkersFromLayer(layer) {
            var property = layer.property("ADBE Marker");
            var numKeys = property.numKeys;
            for (var i = 0; i < numKeys; i += 1) {
                property.removeKey(1);
            }
}
function goThroughAllPropertiesAndDeleteExpressions(propertyGroup) {
            for (var i = 1; i <= propertyGroup.numProperties; i += 1) {
                property = propertyGroup.property(i);
                if (property.propertyType === PropertyType.PROPERTY) {
                    if (property.canSetExpression === true && property.expression !== "") {
                        property.expression = "";
                    }
                } else {
                    goThroughAllPropertiesAndDeleteExpressions(property);
                }
            }
}
function goThroughAllPropertiesAndEnableExpressions(propertyGroup) {
            for (var i = 1; i <= propertyGroup.numProperties; i += 1) {
                property = propertyGroup.property(i);
                if (property.propertyType === PropertyType.PROPERTY) {
                    if (property.canSetExpression === true && property.expression !== "") {
                        property.expressionEnabled = true;
                    }
                } else {
                    goThroughAllPropertiesAndEnableExpressions(property);
                }
            }
}
function goThroughAllPropertiesAndDisableExpressions(propertyGroup) {
            for (var i = 1; i <= propertyGroup.numProperties; i += 1) {
                property = propertyGroup.property(i);
                if (property.propertyType === PropertyType.PROPERTY) {
                    if (property.canSetExpression === true && property.expression !== "") {
                        property.expressionEnabled = false;
                    }
                } else {
                    goThroughAllPropertiesAndDisableExpressions(property);
                }
            }
}
function resetTransformationPropertysOfLayer(layer) {
            var time = app.project.activeItem.time;
            var comp = app.project.activeItem;
            if (layer instanceof CameraLayer) {
                if (layer.autoOrient === AutoOrientType.CAMERA_OR_POINT_OF_INTEREST) {
                    var pointOfInterest = layer.property("ADBE Transform Group").property("ADBE Anchor Point");
                    if (pointOfInterest.numKeys === 0) {
                        pointOfInterest.setValue([comp.width / 2, comp.height / 2, 0])
                    } else {
                        pointOfInterest.setValueAtTime(time, [comp.width / 2, comp.height / 2, 0])
                    }
                }
                var position = layer.property("ADBE Transform Group").property("ADBE Position");
                var negativeZoom = layer.property("ADBE Camera Options Group").property("ADBE Camera Zoom").value * -1;
                if (position.dimensionsSeparated === true) {
                    var positionX = layer.property("ADBE Transform Group").property("ADBE Position_0");
                    var positionY = layer.property("ADBE Transform Group").property("ADBE Position_1");
                    var positionZ = layer.property("ADBE Transform Group").property("ADBE Position_2");
                    if (positionX.numKeys === 0) {
                        positionX.setValue(comp.width / 2)
                    } else {
                        positionX.setValueAtTime(time, comp.width / 2)
                    }
                    if (positionY.numKeys === 0) {
                        positionY.setValue(comp.height / 2)
                    } else {
                        positionY.setValueAtTime(time, comp.height / 2)
                    }
                    if (positionZ.numKeys === 0) {
                        positionZ.setValue(negativeZoom)
                    } else {
                        positionZ.setValueAtTime(time, negativeZoom)
                    }
                } else {
                    if (position.numKeys === 0) {
                        position.setValue([comp.width / 2, comp.height / 2, negativeZoom])
                    } else {
                        position.setValueAtTime(time, [comp.width / 2, comp.height / 2, negativeZoom])
                    }
                }
                var orientation = layer.property("ADBE Transform Group").property("ADBE Orientation");
                if (orientation.numKeys === 0) {
                    orientation.setValue([0, 0, 0])
                } else {
                    orientation.setValueAtTime(time, [0, 0, 0])
                }
                var rotationX = layer.property("ADBE Transform Group").property("ADBE Rotate X");
                var rotationY = layer.property("ADBE Transform Group").property("ADBE Rotate Y");
                var rotationZ = layer.property("ADBE Transform Group").property("ADBE Rotate Z");
                if (rotationX.numKeys === 0) {
                    rotationX.setValue(0)
                } else {
                    rotationX.setValueAtTime(time, 0)
                }
                if (rotationY.numKeys === 0) {
                    rotationY.setValue(0)
                } else {
                    rotationY.setValueAtTime(time, 0)
                }
                if (rotationZ.numKeys === 0) {
                    rotationZ.setValue(0)
                } else {
                    rotationZ.setValueAtTime(time, 0)
                }
            } else if (layer instanceof LightLayer) {
                if (layer.lightType === LightType.AMBIENT) {

                } else {
                    var distanceFromCenter = 0.0416666666666667 * comp.width;
                    var lightPosX = (comp.width / 2) + distanceFromCenter;
                    var lightPosY = (comp.height / 2) - distanceFromCenter;
                    var lightPosZ = 0.347222222222222 * comp.width * -1;
                    var position = layer.property("ADBE Transform Group").property("ADBE Position");
                    if (position.dimensionsSeparated === true) {
                        var positionX = layer.property("ADBE Transform Group").property("ADBE Position_0");
                        var positionY = layer.property("ADBE Transform Group").property("ADBE Position_1");
                        var positionZ = layer.property("ADBE Transform Group").property("ADBE Position_2");
                        if (positionX.numKeys === 0) {
                            positionX.setValue(lightPosX)
                        } else {
                            positionX.setValueAtTime(time, lightPosX)
                        }
                        if (positionY.numKeys === 0) {
                            positionY.setValue(lightPosY)
                        } else {
                            positionY.setValueAtTime(time, lightPosY)
                        }
                        if (positionZ.numKeys === 0) {
                            positionZ.setValue(lightPosZ)
                        } else {
                            positionZ.setValueAtTime(time, lightPosZ)
                        }
                    } else {
                        if (position.numKeys === 0) {
                            position.setValue([lightPosX, lightPosY, lightPosZ])
                        } else {
                            position.setValueAtTime(time, [lightPosX, lightPosY, lightPosZ])
                        }
                    }
                    if (layer.lightType === LightType.PARALLEL) {
                        if (layer.autoOrient === AutoOrientType.CAMERA_OR_POINT_OF_INTEREST) {
                            var pointOfInterest = layer.property("ADBE Transform Group").property("ADBE Anchor Point");
                            if (pointOfInterest.numKeys === 0) {
                                pointOfInterest.setValue([comp.width / 2, comp.height / 2, 0])
                            } else {
                                pointOfInterest.setValueAtTime(time, [comp.width / 2, comp.height / 2, 0])
                            }
                        }
                    }
                    if (layer.lightType === LightType.SPOT) {
                        if (layer.autoOrient === AutoOrientType.CAMERA_OR_POINT_OF_INTEREST) {
                            var pointOfInterest = layer.property("ADBE Transform Group").property("ADBE Anchor Point");
                            if (pointOfInterest.numKeys === 0) {
                                pointOfInterest.setValue([comp.width / 2, comp.height / 2, 0])
                            } else {
                                pointOfInterest.setValueAtTime(time, [comp.width / 2, comp.height / 2, 0])
                            }
                        }
                        var orientation = layer.property("ADBE Transform Group").property("ADBE Orientation");
                        if (orientation.numKeys === 0) {
                            orientation.setValue([0, 0, 0])
                        } else {
                            orientation.setValueAtTime(time, [0, 0, 0])
                        }
                        var rotationX = layer.property("ADBE Transform Group").property("ADBE Rotate X");
                        var rotationY = layer.property("ADBE Transform Group").property("ADBE Rotate Y");
                        var rotationZ = layer.property("ADBE Transform Group").property("ADBE Rotate Z");
                        if (rotationX.numKeys === 0) {
                            rotationX.setValue(0)
                        } else {
                            rotationX.setValueAtTime(time, 0)
                        }
                        if (rotationY.numKeys === 0) {
                            rotationY.setValue(0)
                        } else {
                            rotationY.setValueAtTime(time, 0)
                        }
                        if (rotationZ.numKeys === 0) {
                            rotationZ.setValue(0)
                        } else {
                            rotationZ.setValueAtTime(time, 0)
                        }
                    }
                }
            } else if (layer instanceof ShapeLayer || layer instanceof TextLayer) {
                var anchorPoint = layer.property("ADBE Transform Group").property("ADBE Anchor Point");
                var scale = layer.property("ADBE Transform Group").property("ADBE Scale");
                var rotationZ = layer.property("ADBE Transform Group").property("ADBE Rotate Z");
                var opacity = layer.property("ADBE Transform Group").property("ADBE Opacity");
                var position = layer.property("ADBE Transform Group").property("ADBE Position");
                if (anchorPoint.numKeys === 0) {
                    anchorPoint.setValue([0, 0, 0])
                } else {
                    anchorPoint.setValueAtTime(time, [0, 0, 0])
                }
                if (scale.numKeys === 0) {
                    scale.setValue([100, 100, 100])
                } else {
                    scale.setValueAtTime(time, [100, 100, 100])
                }
                if (rotationZ.numKeys === 0) {
                    rotationZ.setValue(0)
                } else {
                    rotationZ.setValueAtTime(time, 0)
                }
                if (opacity.numKeys === 0) {
                    opacity.setValue(100)
                } else {
                    opacity.setValueAtTime(time, 100)
                }
                if (position.dimensionsSeparated === true) {
                    var positionX = layer.property("ADBE Transform Group").property("ADBE Position_0");
                    var positionY = layer.property("ADBE Transform Group").property("ADBE Position_1");
                    if (positionX.numKeys === 0) {
                        positionX.setValue(comp.width / 2)
                    } else {
                        positionX.setValueAtTime(time, comp.width / 2)
                    }
                    if (positionY.numKeys === 0) {
                        positionY.setValue(comp.height / 2)
                    } else {
                        positionY.setValueAtTime(time, comp.height / 2)
                    }
                    if (layer.threeDLayer === true) {
                        var positionZ = layer.property("ADBE Transform Group").property("ADBE Position_2");
                        if (positionZ.numKeys === 0) {
                            positionZ.setValue(0)
                        } else {
                            positionZ.setValueAtTime(time, 0)
                        }
                    }
                } else {
                    if (position.numKeys === 0) {
                        position.setValue([comp.width / 2, comp.height / 2, 0])
                    } else {
                        position.setValueAtTime(time, [comp.width / 2, comp.height / 2, 0])
                    }
                }
                if (layer.threeDLayer === true) {
                    var orientation = layer.property("ADBE Transform Group").property("ADBE Orientation");
                    var rotationX = layer.property("ADBE Transform Group").property("ADBE Rotate X");
                    var rotationY = layer.property("ADBE Transform Group").property("ADBE Rotate Y");
                    if (orientation.numKeys === 0) {
                        orientation.setValue([0, 0, 0])
                    } else {
                        orientation.setValueAtTime(time, [0, 0, 0])
                    }
                    if (rotationX.numKeys === 0) {
                        rotationX.setValue(0)
                    } else {
                        rotationX.setValueAtTime(time, 0)
                    }
                    if (rotationY.numKeys === 0) {
                        rotationY.setValue(0)
                    } else {
                        rotationY.setValueAtTime(time, 0)
                    }
                }
            } else {
                if (layer instanceof AVLayer) {
                    if (layer.nullLayer) {
                        var anchorPoint = layer.property("ADBE Transform Group").property("ADBE Anchor Point");
                        var scale = layer.property("ADBE Transform Group").property("ADBE Scale");
                        var rotationZ = layer.property("ADBE Transform Group").property("ADBE Rotate Z");
                        var opacity = layer.property("ADBE Transform Group").property("ADBE Opacity");
                        var position = layer.property("ADBE Transform Group").property("ADBE Position");
                        if (anchorPoint.numKeys === 0) {
                            anchorPoint.setValue([0, 0, 0])
                        } else {
                            anchorPoint.setValueAtTime(time, [0, 0, 0])
                        }
                        if (scale.numKeys === 0) {
                            scale.setValue([100, 100, 100])
                        } else {
                            scale.setValueAtTime(time, [100, 100, 100])
                        }
                        if (rotationZ.numKeys === 0) {
                            rotationZ.setValue(0)
                        } else {
                            rotationZ.setValueAtTime(time, 0)
                        }
                        if (opacity.numKeys === 0) {
                            opacity.setValue(0)
                        } else {
                            opacity.setValueAtTime(time, 0)
                        }
                        if (position.dimensionsSeparated === true) {
                            var positionX = layer.property("ADBE Transform Group").property("ADBE Position_0");
                            var positionY = layer.property("ADBE Transform Group").property("ADBE Position_1");
                            if (positionX.numKeys === 0) {
                                positionX.setValue(comp.width / 2)
                            } else {
                                positionX.setValueAtTime(time, comp.width / 2)
                            }
                            if (positionY.numKeys === 0) {
                                positionY.setValue(comp.height / 2)
                            } else {
                                positionY.setValueAtTime(time, comp.height / 2)
                            }
                            if (layer.threeDLayer === true) {
                                var positionZ = layer.property("ADBE Transform Group").property("ADBE Position_2");
                                if (positionZ.numKeys === 0) {
                                    positionZ.setValue(0)
                                } else {
                                    positionZ.setValueAtTime(time, 0)
                                }
                            }
                        } else {
                            if (position.numKeys === 0) {
                                position.setValue([comp.width / 2, comp.height / 2, 0])
                            } else {
                                position.setValueAtTime(time, [comp.width / 2, comp.height / 2, 0])
                            }
                        }
                        if (layer.threeDLayer === true) {
                            var orientation = layer.property("ADBE Transform Group").property("ADBE Orientation");
                            var rotationX = layer.property("ADBE Transform Group").property("ADBE Rotate X");
                            var rotationY = layer.property("ADBE Transform Group").property("ADBE Rotate Y");
                            if (orientation.numKeys === 0) {
                                orientation.setValue([0, 0, 0])
                            } else {
                                orientation.setValueAtTime(time, [0, 0, 0])
                            }
                            if (rotationX.numKeys === 0) {
                                rotationX.setValue(0)
                            } else {
                                rotationX.setValueAtTime(time, 0)
                            }
                            if (rotationY.numKeys === 0) {
                                rotationY.setValue(0)
                            } else {
                                rotationY.setValueAtTime(time, 0)
                            }
                        }
                    } else if (!layer.hasVideo) {

                    } else {
                        var anchorPoint = layer.property("ADBE Transform Group").property("ADBE Anchor Point");
                        var scale = layer.property("ADBE Transform Group").property("ADBE Scale");
                        var rotationZ = layer.property("ADBE Transform Group").property("ADBE Rotate Z");
                        var opacity = layer.property("ADBE Transform Group").property("ADBE Opacity");
                        var position = layer.property("ADBE Transform Group").property("ADBE Position");
                        if (anchorPoint.numKeys === 0) {
                            anchorPoint.setValue([layer.width / 2, layer.height / 2, 0])
                        } else {
                            anchorPoint.setValueAtTime(time, [layer.width / 2, layer.height / 2, 0])
                        }
                        if (scale.numKeys === 0) {
                            scale.setValue([100, 100, 100])
                        } else {
                            scale.setValueAtTime(time, [100, 100, 100])
                        }
                        if (rotationZ.numKeys === 0) {
                            rotationZ.setValue(0)
                        } else {
                            rotationZ.setValueAtTime(time, 0)
                        }
                        if (opacity.numKeys === 0) {
                            opacity.setValue(100)
                        } else {
                            opacity.setValueAtTime(time, 100)
                        }
                        if (position.dimensionsSeparated === true) {
                            var positionX = layer.property("ADBE Transform Group").property("ADBE Position_0");
                            var positionY = layer.property("ADBE Transform Group").property("ADBE Position_1");
                            if (positionX.numKeys === 0) {
                                positionX.setValue(comp.width / 2)
                            } else {
                                positionX.setValueAtTime(time, comp.width / 2)
                            }
                            if (positionY.numKeys === 0) {
                                positionY.setValue(comp.height / 2)
                            } else {
                                positionY.setValueAtTime(time, comp.height / 2)
                            }
                            if (layer.threeDLayer === true) {
                                var positionZ = layer.property("ADBE Transform Group").property("ADBE Position_2");
                                if (positionZ.numKeys === 0) {
                                    positionZ.setValue(0)
                                } else {
                                    positionZ.setValueAtTime(time, 0)
                                }
                            }
                        } else {
                            if (position.numKeys === 0) {
                                position.setValue([comp.width / 2, comp.height / 2, 0])
                            } else {
                                position.setValueAtTime(time, [comp.width / 2, comp.height / 2, 0])
                            }
                        }
                        if (layer.threeDLayer === true) {
                            var orientation = layer.property("ADBE Transform Group").property("ADBE Orientation");
                            var rotationX = layer.property("ADBE Transform Group").property("ADBE Rotate X");
                            var rotationY = layer.property("ADBE Transform Group").property("ADBE Rotate Y");
                            if (orientation.numKeys === 0) {
                                orientation.setValue([0, 0, 0])
                            } else {
                                orientation.setValueAtTime(time, [0, 0, 0])
                            }
                            if (rotationX.numKeys === 0) {
                                rotationX.setValue(0)
                            } else {
                                rotationX.setValueAtTime(time, 0)
                            }
                            if (rotationY.numKeys === 0) {
                                rotationY.setValue(0)
                            } else {
                                rotationY.setValueAtTime(time, 0)
                            }
                        }
                    }
                }
            }
}
function resetAllOnThisLayer(layer) {
            deleteAllEffectsFromLayer(layer);
            deleteAllMasksFromLayer(layer);
            goThroughAllPropertiesAndDeleteKeys(layer);
            deleteAllMarkersFromLayer(layer);
            goThroughAllPropertiesAndDeleteExpressions(layer);
            resetTransformationPropertysOfLayer(layer);
}