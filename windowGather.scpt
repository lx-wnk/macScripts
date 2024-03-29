-- got from: https://snipplr.com/view/8645/gather-windows/
-- author: https://snipplr.com/users/bradchoate/
-- work from me: removed some UNICODE Characteres
tell application "Finder"
	-- get desktop dimensions (dw = desktop width; dh = desktop height)
	set db to bounds of window of desktop
	set {dw, dh} to {item 3 of db, item 4 of db}
end tell

tell application "System Events"
	repeat with proc in application processes
		tell proc
			repeat with win in windows
				-- get window dimensions (w = width; h = height)
				set {w, h} to size of win
				
				-- get window postion (l = left of window; t = top of window)
				set {l, t} to position of win
				
				-- nh = new window height; nw = new window width
				set {nh, nw} to {h, w}
				
				-- window width is bigger than desktop size,
				-- so set new window width to match the desktop
				if (w > dw) then
					set nw to dw
				end if
				
				-- window height is bigger than the desktop size (minus menu bar),
				-- so set new window height to be desktop height - 22 pixels
				if (h > dh - 22) then
					set nh to dh - 22
				end if
				
				-- r = right coordinate of window; b = bottom coordinate of window
				set {r, b} to {l + nw, t + nh}
				
				-- nl = new left coordinate; nt = new top coordinate
				set {nl, nt} to {l, t}
				
				-- left coordinate is off screen, so set new left coordinate
				-- to be 0 (at the left edge of the desktop)
				if (l < 0) then
					set nl to 0
				end if
				
				-- top coordinate is above bottom of menu bar (22 pixels tall),
				-- so set new top coordinate to be 22
				if (t < 22) then
					set nt to 22
				end if
				
				-- right coordinate extends beyond desktop width,
				-- so set new left coordinate to be desktop width - window width
				if (r > dw) then
					set nl to dw - nw
				end if
				
				-- bottom coordinate extends beyond desktop height,
				-- so set new top coordinate to be desktop height - window height
				if (b > dh) then
					set nt to dh - nh
				end if
				
				-- if we have calculated a new top or left coordinate, reposition window
				if (l is nl or t is nt) then
					set position of win to {nl, nt}
				end if
				
				-- if we have calculated a new height or width, resize window
				if (h is nh or w is nw) then
					set size of win to {nw, nh}
				end if
			end repeat
		end tell
	end repeat
end tell
