$times = [
    '00:00 - 02:30',
    '02:00 - 04:30',
    '04:00 - 06:30',
    '06:00 - 08:30',
    '08:00 - 10:30',
    '10:00 - 12:30',
    '12:00 - 14:30',
    '14:00 - 16:30',
    '16:00 - 18:30',
    '18:00 - 20:30',
    '20:00 - 22:30',
    '22:00 - 00:30'
]

def gen_stage_areas(day)
    # Generate basic building block:
    #     which area is loadshed at each time in stage 1

    if day > 16
        day -= 16
    end
    i = ((day * 12 - 11) % 16) + (day - 1) / 4
    (i..i+11).map {|a| (a - 1) % 16 + 1}
end

def combinations(day)
    # Generate the combinations of stage 1 days used for the given stage 4 day
    m = ((day + 3) / 4) * 4
    [day, day + 2, day + 1, day + 3].map {|a| a <= m ? a : a - 4}
end

def combinations_for_stage(day, stage)
    # Cut down combinations to only those required for the current stage
    combinations(day)[0...stage]
end

def blocks_for_day(day, stage)
    # Build list of areas per time for the given stage
    first, *rest = combinations_for_stage(day, stage).map { |c| gen_stage_areas(c) }
    first.zip(*rest)
end

def times_per_day_per_stage(area, day, stage)
    # Determine which times the given stage is being load shed in the given day
    m = $times.zip(blocks_for_day(day, stage))
    m.select { |e| e[1].include? area }.map { |e| e[0] }
end

(1..16).each do | area |
    (1..4).each do | stage |
        (1..31).each do | day |
            Schedule.create!(
                stage: stage,
                area: area,
                day_of_month: day,
                outtages: times_per_day_per_stage(area, day, stage).join(', ')
            )
        end
    end
end
