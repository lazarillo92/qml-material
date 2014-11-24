/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Bogdan Cuza <bogdan.cuza@hotmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0

Rectangle {
	id: wave

	property real realX
	property real realY
		
	x: realX-(size/2)
	y: realY-(size/2)

	function getDiameter() {
		var topLeftCorner = Math.sqrt(Math.pow((x - 0), 2) + Math.pow((y - 0), 2));
		var topRightCorner = Math.sqrt(Math.pow((x - parent.width), 2) + Math.pow((y - 0), 2));
		var bottomLeftCorner = Math.sqrt(Math.pow((x - 0), 2) + Math.pow((y - parent.height), 2));
		var bottomRightCorner = Math.sqrt(Math.pow((x - parent.width), 2) + Math.pow((y - parent.height), 2));
		return 2*Math.max(topLeftCorner, topRightCorner, bottomLeftCorner, bottomRightCorner);
	}

	property real size: 0
	property real diameter: getDiameter()

	signal finished

	width: size
	height: size
	radius: size/2

	function run() {
		waveAnim.start();
	}

	SequentialAnimation {
		running: false
		id: waveAnim

		onRunningChanged: {
			if (!running) {
				wave.size = 0;
				wave.opacity = 1;
				wave.finished();
			}
		}

		NumberAnimation {
			target: wave
			properties: "size"
			duration: 500
			from: 0
			to: wave.diameter
			easing.type: Easing.InCubic
		}
		NumberAnimation {
			target: wave
			properties: "opacity"
			duration: 250
			from: 1
			to: 0
			easing.type: Easing.InCubic
		}
	}
}
